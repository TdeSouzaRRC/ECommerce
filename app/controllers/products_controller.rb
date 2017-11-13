class ProductsController < ApplicationController
  def show 
    @product = Product.find(params[:id])
  end

  def search
    keyword = sanitize_sql(params["search_for"])

    if keyword == nil then
      @products = Product.All
    else 
      @products = Product.where("name LIKE %?% OR description LIKE %?%",keyword,keyword)
    end

    render "home/index"
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
