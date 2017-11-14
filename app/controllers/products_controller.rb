class ProductsController < ApplicationController
  before_action :initialize_session, only: [:add_product_to_cart]

  def show 
    @product = Product.find(params[:id])
  end

  def search
    @categories = Category.all
    
    @selected_category = params["category"]
    @selected_category_name = "All"
    @keyword = params["search_for"]
    like_keyword = "%"+ @keyword + "%"

    if (@keyword == "") && (@selected_category == "")  then

      @products = Product.all.order(:name)
    
    elsif (@keyword == "") && (@selected_category != "") then
    
      @selected_category_name = Category.find(params["category"]).name
      @products = Category.find(@selected_category).products.order(:name)
    
    elsif (@keyword != "") && (@selected_category == "")
    
      @products = Product.where("name LIKE ? OR description LIKE ?", like_keyword, like_keyword).order(:name)
    
    else  

      @selected_category_name = Category.find(params["category"]).name
      @products = Product.where("(name LIKE ? OR description LIKE ?) AND category_id = ?", like_keyword, like_keyword, @selected_category).order(:name)
    
    end
  end

  def by_category
    category = Category.find(params["id"])
    if category != nil then
      @products = category.products
    else
      @products = nil
    end

    render json: @products
  end

  def add_product_to_cart
    session[:cart] << params[:id] unless session[:cart].include?(params[:id])

    redirect_back(fallback_location: root_path)
  end
  
  private

  def initialize_session
    session[:cart] ||= []
  end
end
