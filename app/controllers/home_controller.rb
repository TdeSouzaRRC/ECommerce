class HomeController < ApplicationController
  def index
    @categories = Category.all

    if params["category"] != nil then
      @categories.each do |category|
        if category.name == params["category"] then
          @products = category.products
        end
      end
    else
      @products = Product.all
    end
  end

  def about
    @company_info = CompanyInfo.first
  end

  def contact
    @company_info = CompanyInfo.first
  end
end
