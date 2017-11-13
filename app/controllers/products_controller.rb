class ProductsController < ApplicationController
  def show 
    @product = Product.find(params[:id])
  end

  def search
    @keyword = params["search_for"]
    
    if @keyword == nil then
      @products = Product.All
    else
      like_keyword = "%"+ @keyword + "%"
      @products = Product.where("name LIKE ? OR description LIKE ?", like_keyword, like_keyword)
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
