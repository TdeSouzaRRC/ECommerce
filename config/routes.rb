Rails.application.routes.draw do
  get 'products/show'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  root to: 'home#index'

  get "/", to: "home#index", as: "products" 
  get "/about", to: "home#about", as:"about"
  get "/checkout", to: "home#checkout", as: "checkout"
  get "/contact", to: "home#contact", as:"contact"
  get "/login", to: "home#login", as: "login"
  get "/products/:id", to: "products#show", as:"product", id: /\d+/
  get "/products/by_category/:id", to: "products#by_category", id: /\d+/
  get "/products/search", to: "products#search"
  get "/register", to: "home#register", as:"register"
  get "/shopping_cart", to: "home#shopping_cart", as: "shopping_cart"

  post "/products/:id/add_to_cart", to: "products#add_product_to_cart" , as: "add_to_cart", id: /\d+/
  post "/products/:id/remove_from_cart", to: "products#remove_product_from_cart" , as: "remove_from_cart", id: /\d+/
  post "/products/:id/add_product_quantity_to_cart", to:"products#add_product_quantity_to_cart" , as: "add_product_quantity_to_cart", id: /\d+/
  post "/products/:id/remove_product_quantity_from_cart", to:"products#remove_product_quantity_from_cart" , as: "remove_product_quantity_from_cart", id: /\d+/

  post "/login", to: "home#login", as: "login_process"
  post "/logout", to: "home#logout", as: "logout"
  post "/register", to: "home#register", as:"register_process"

  resources :charges
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

