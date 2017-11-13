class HomeController < ApplicationController
  def index
    @categories = Category.all
    @selected_category = nil;
    if params["category"] != nil then
      @categories.each do |category|
        if category.name == params["category"] then
          @products = category.products
          @selected_category = category.name
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
