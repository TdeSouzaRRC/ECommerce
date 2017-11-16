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

  private 

  def initialize_session
    session[:cart] ||= []
  end
end
