class HomeController < ApplicationController
  def index
    @products = Product.all
    @categories = Category.all
  end

  def about
    @company_info = CompanyInfo.first
  end

  def contact
    @company_info = CompanyInfo.first
  end
end
