Rails.application.routes.draw do
  get 'customers/register'

  get 'products/show'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  root to: 'home#index'

  #General
  get "/", to: "home#index", as: "products" 
  get "/about", to: "home#about", as:"about"
  get "/checkout", to: "home#checkout", as: "checkout"
  get "/contact", to: "home#contact", as:"contact"
  get "/shopping_cart", to: "home#shopping_cart", as: "shopping_cart"

  #Products
  get "/products/:id", to: "products#show", as:"product", id: /\d+/
  get "/products/by_category/:id", to: "products#by_category", id: /\d+/
  get "/products/search", to: "products#search"
  
  post "/products/:id/add_to_cart", to: "products#add_product_to_cart" , as: "add_to_cart", id: /\d+/
  post "/products/:id/remove_from_cart", to: "products#remove_product_from_cart" , as: "remove_from_cart", id: /\d+/
  post "/products/:id/add_product_quantity_to_cart", to:"products#add_product_quantity_to_cart" , as: "add_product_quantity_to_cart", id: /\d+/
  post "/products/:id/remove_product_quantity_from_cart", to:"products#remove_product_quantity_from_cart" , as: "remove_product_quantity_from_cart", id: /\d+/

  #Customer/Login
  get "/my_account", to: "customers#my_account", as: "my_account"
  get "/login", to: "customers#login", as: "login"
  get "/register", to: "customers#register", as:"register"
  get "/register_info/:id", to:"customers#register_info", as: "register_info", id: /\d+/

  post "/login", to: "customers#login", as: "login_process"
  post "/logout", to: "customers#logout", as: "logout"
  post "/register", to: "customers#register", as:"register_process"
  post "/register_info/:id", to:"customers#register_info", as: "register_info_process", id: /\d+/

  resources :charges
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

