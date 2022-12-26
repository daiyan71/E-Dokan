Rails.application.routes.draw do
  resources :ratings, only: [:new, :create, :update]
  resources :user_profiles, only: [:show]
  resources :orders, only: [:new, :create, :index, :show, :destroy] do
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
    delete :destroy_cart_item
  end

  controller :admin_home do
    get :admin_home, to: 'admin_home#index'
    get :product_reviews
    get :manage_orders
    get :order_details
    get :set_order_status
  end

  root to: "home#index"
end
