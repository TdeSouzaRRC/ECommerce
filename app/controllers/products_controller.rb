class ProductsController < ApplicationController
  def show 
    @product = Product.find(params[:id])
  end

  def search
    @categories = Category.all
    
    @selected_category = params["category"]
    @selected_category_name = Category.find(params["category"]).name
    @keyword = params["search_for"]
    like_keyword = "%"+ @keyword + "%"

    if (@keyword == "") && (@selected_category == "")  then

      @products = Product.all
    
    elsif (@keyword == "") && (@selected_category != "") then
    
      @products = Category.find(@selected_category).products
    
    elsif (@keyword != "") && (@selected_category == "")
    
      @products = Product.where("name LIKE ? OR description LIKE ?", like_keyword, like_keyword)
    
    else  

      @products = Product.where("(name LIKE ? OR description LIKE ?) AND category_id = ?", like_keyword, like_keyword, @selected_category)
    
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

  
end
