class HomeController < ApplicationController
  before_action :initialize_session, only: [:index]
  
  def index
    @categories = Category.all.order(:name)
    @selected_category = nil;
    if params["category"] != nil then
      @categories.each do |category|
        if category.name == params["category"] then
          @products = category.products.order(:name)
          @selected_category = category.name
        end
      end
    else
      @products = Product.all.order(:name)
    end
  end

  def about
    @company_info = CompanyInfo.first
  end

  def contact
    @company_info = CompanyInfo.first
  end

  def shopping_cart
    @products = Product.find(session[:cart].keys)
    @subtotal = 0

    @products.each do |product|
      @subtotal += product.price * session[:cart][product.id.to_s].to_i
    end
  end

  def register
    if request.post?
      @customer = Customer.new(params["customer"])
      if @customer.valid?
        customer = Stripe::Customer.create(
          :email => params[:stripeEmail],
          :source  => params[:stripeToken]
        )
        redirect_to login_path
      else
        # redirect_back fallback_location: register_path
      end
    else
      @customer = Customer.new
    end

  end

  def login
    @error_message = false
    if request.post? then
      user = UserLogin.find_by "email = ? and password = ?", params["email"], params["password"]
      unless user.nil? then
        session[:user_logged_in] = user.customer.id
        redirect_to checkout_path
      else
        @error_message = true
      end
    end
  end

  def checkout
    if session[:user_logged_in].nil? then
      redirect_to login_path
    else
      @customer = Customer.find(session[:user_logged_in])
      @order_items = []
      @subtotal = 0;
      
      session[:cart].keys.each do |item|
        product = Product.find(item)
        quantity = session[:cart][item].to_i
        
        unless(product.nil?) then
          order_item = {
            "product_id" => product.id,
            "product_name" => product.name,
            "quantity" => quantity,
            "price" => product.price,
            "total_price" => quantity*product.price
          }
          @order_items << order_item
          @subtotal += quantity*product.price
        end
      end
      
      @pst = @subtotal * @customer.province.pst.to_f
      @gst = @subtotal * @customer.province.gst.to_f
      @hst = @subtotal * @customer.province.hst.to_f
      @total = @subtotal + @pst + @gst + @hst
      
      # Checks if an order was not created yet
      if session["order"].nil?
        order = Order.create( 
          :pst_rate => @customer.province.pst,
          :gst_rate => @customer.province.gst,
          :hst_rate => @customer.province.hst,
          :customer_id => @customer.id,
          :order_status_id => 1
        )
        
        @order_items.each do |item|
          LineItem.create(:quantity => item["quantity"], :price => item["price"], :product_id => item["product_id"], :order_id => order.id)    
        end

        session["order"] = order.id
      else
        # In case of order not completed and changed
        # Updates order with new information
        order = Order.find(session["order"]) 
        order.pst_rate = @customer.province.pst
        order.gst_rate = @customer.province.gst
        order.hst_rate = @customer.province.hst
        order.customer_id = @customer.id

        # Destroys all order items
        order.line_items.each do |item|
          item.destroy
        end
        
        # Recreates all order items
        @order_items.each do |item|
          order.line_items.create(:quantity => item["quantity"], :price => item["price"], :product_id => item["product_id"])    
        end
      end
    end    
  end

  private 

  def initialize_session
    session[:cart] ||= {}
  end
end
