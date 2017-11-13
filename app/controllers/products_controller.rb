class ProductsController < ApplicationController
  def show 
    @product = Product.find(params[:id])
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
