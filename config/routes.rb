Rails.application.routes.draw do
  get 'products/show'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  root to: 'home#index'

  get "/about", to: "home#about", as:"about"
  get "/contact", to: "home#contact", as:"contact"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
