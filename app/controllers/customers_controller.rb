class CustomersController < ApplicationController
  def register
    @user_login = UserLogin.new

    if request.post?
      @user_login.email = params['user_login']['email']
      @user_login.password = params['user_login']['password']

      if params['user_login']['password'] != params['user_login']['retype_password']
        @user_login.errors.add(:password, ' does not match re-type.')
      end

      unless @user_login.errors.any?
        @user_login.save
        session[:user_register_in] = @user_login.id
        redirect_to register_info_path(@user_login)
      end
    end
  end

  def register_info
    if session[:user_register_in].nil? && session[:user_logged_in].nil?
      redirect_to products_path
    end

    if session[:user_logged_in].nil?
      @user_login = UserLogin.find(session[:user_register_in])
    else
      @user_login = UserLogin.find(session[:user_logged_in])
    end
    @provinces = Province.all.map { |province| [province.name, province.id] }

    if @user_login.customer.nil?
      @customer = Customer.new
      @customer.user_login_id = @user_login.id
      @customer.email = @user_login.email
    else
      @customer = @user_login.customer
    end

    if request.post?
      @customer.full_name = params['customer']['full_name']
      @customer.address = params['customer']['address']
      @customer.city = params['customer']['city']
      @customer.postal_code = params['customer']['postal_code']
      @customer.country = params['customer']['country']
      @customer.province_id = params['customer']['province_id']

      if @customer.valid?
        customer = Stripe::Customer.create(
          :email => @customer.email
        )

        @customer.unique_identifier = customer.id
        @customer.save
        session[:user_register_in] = nil
        redirect_to login_path
      end
    end
  end

  def my_account
    if session[:user_logged_in].nil?
      redirect_to products_path
    end

    @user = UserLogin.find(session[:user_logged_in])
    @customer = @user.customer
  end

  def login
    if session[:user_logged_in].nil?
      @error_message = false
      if request.post?
        user = UserLogin.find_by 'email = ? and password = ?', params['email'], params['password']
        if !user.nil?
          session[:user_logged_in] = user.id
          session[:user_name] = user.customer.full_name
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
      session[:user_name] = nil
    end
      redirect_to products_path
  end
end
