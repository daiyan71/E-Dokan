Rails.application.routes.draw do
  resources :products
  resources :product_categories
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
end
