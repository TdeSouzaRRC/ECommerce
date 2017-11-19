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

  def login

  end

  def checkout
    unless !session[:user_logged_in].nil? false then
      redirect_to login_path
    end

    order_items = []
    subtotal = 0;

    session[:cart].keys.each do |item|
      product = Product.find(item)
      quantity = session[:cart][item].to_i

      unless(product.nil?) then    
        order_item = {
          "product_name" => product.name,
          "quantity" => quantity,
          "price" => product.price,
          "total_price" => quantity*product.price
        }
        order_items << order_item
        subtotal += quantity*product.price
      end
    end
    
    session[:line_items] = {
      "order_items" => order_items,
      "subtotal" => subtotal
    } 
  end

  private 

  def initialize_session
    session[:cart] ||= {}
  end
end
