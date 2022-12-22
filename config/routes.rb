Rails.application.routes.draw do
  resources :orders, only: [:new, :create] do
    member do
      get :payment
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
  end

  root to: "home#index"
end
