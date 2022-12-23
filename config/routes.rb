Rails.application.routes.draw do
  resources :orders, only: [:new, :create, :index] do
    member do
      get :payment
      delete :cancel
    end
  end
  resources :charges, only: [:new, :create]
  resources :products
  resources :product_categories
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  controller :home do
    get :product_details
    get :add_to_cart
    get :cart
    delete :destroy_cart
    delete :destroy_cart_item
  end

  root to: "home#index"
end
