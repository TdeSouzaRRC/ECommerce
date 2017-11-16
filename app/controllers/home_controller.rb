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
    @products = Product.find(session[:cart])
  end

  def summary_build
    line_items = []

    params[:line_item].each do |item|
      product = Product.find(item["product_id"])

      unless(product.nil?) then
        temp_line_item = LineItem.new
        temp_line_item.quantity = item["quantity"]
        temp_line_item.price = product.price * temp_line_item.quantity
        temp_line_item.product_id = product.id
        line_items << temp_line_item
      end
    end
    
    session[:line_items] = line_items
    
    redirect_to checkout_path
  end

  private 

  def initialize_session
    session[:cart] ||= []
  end
end
