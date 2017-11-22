class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def search
    @categories = Category.all

    @selected_category = params['category']
    @selected_category_name = 'All'
    @keyword = params['search_for']
    like_keyword = '%' + @keyword + '%'

    if (@keyword == '') && (@selected_category == '')

      @products = Product.all.order(:name)

    elsif (@keyword == '') && (@selected_category != '')

      @selected_category_name = Category.find(params['category']).name
      @products = Category.find(@selected_category).products.order(:name)

    elsif (@keyword != '') && (@selected_category == '')

      @products = Product.where('name LIKE ? OR description LIKE ?',
                                like_keyword,
                                like_keyword).order(:name)

    else

      @selected_category_name = Category.find(params['category']).name
      @products = Product.where('(name LIKE ? OR description LIKE ?) AND category_id = ?',
                                like_keyword,
                                like_keyword,
                                @selected_category).order(:name)
    end
  end

  def by_category
    category = Category.find(params['id'])
    if !category.nil?
      @products = category.products
    else
      @products = nil
    end

    render json: @products
  end

  def add_product_to_cart
    # session[:cart] << params[:id] unless session[:cart].include?(params[:id])
    session[:cart][params[:id]] = 1 unless session[:cart].key?(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def remove_product_from_cart
    session[:cart].delete(params[:id]) unless session[:cart].key?(params[:id]) == false

    redirect_back(fallback_location: shopping_cart_path)
  end

  def add_product_quantity_to_cart
    session[:cart][params[:id]] += 1
    redirect_back(fallback_location: root_path)
  end

  def remove_product_quantity_from_cart
    session[:cart][params[:id]] -= 1 unless session[:cart][params[:id]] <= 1
    redirect_back(fallback_location: root_path)
  end
end
