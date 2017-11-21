class CustomersController < ApplicationController
  def register
    @user_login = UserLogin.new

    if request.post?        
      @user_login.email = params["user_login"]["email"]
      @user_login.password = params["user_login"]["password"]

      if params["user_login"]["password"] != params["user_login"]["retype_password"]
        @user_login.errors.add(:password," doesn't match re-type.")
      end

      unless @user_login.errors.any? 
        @user_login.save
        session[:user_logged_in] = @user_login.id
        redirect_to register_info_path(@user_login)
      end
    end
  end

  def register_info
    if session[:user_logged_in].nil?
      redirect_to products_path
    end

    @user_login = UserLogin.find(session[:user_logged_in])
    @provinces = Province.all.map {|province| [province.name, province.id]}
    
    if @user_login.customer.nil?
      @customer = Customer.new
      @customer.user_login_id = @user_login.id
      @customer.email = @user_login.email
    else
      @customer = @user_login.customer
    end

    if request.post?
      @customer.full_name = params["customer"]["full_name"]
      @customer.address = params["customer"]["address"]
      @customer.city = params["customer"]["city"]
      @customer.postal_code = params["customer"]["postal_code"]
      @customer.country = params["customer"]["country"]
      @customer.province_id = params["customer"]["province_id"]

      if @customer.valid?
        customer = Stripe::Customer.create(
          :email => params[:stripeEmail]
        )

        @customer.unique_identifier = customer.id
        @customer.save
        session[:user_logged_in] = {}
        redirect_to login_path
      end
    end
  end

  def my_account
    
  end

  def login
    if session[:user_logged_in].nil?
      @error_message = false
      if request.post? then
        user = UserLogin.find_by "email = ? and password = ?", params["email"], params["password"]
        unless user.nil? then
          session[:user_logged_in] = user.customer.id
          redirect_back fallback_location: products_path
        else
          @error_message = true
        end
      end
    else
      redirect_to products_path
    end
  end

  def logout
    if request.post?
      session[:user_logged_in] = nil
    end
      redirect_to products_path
  end
end
