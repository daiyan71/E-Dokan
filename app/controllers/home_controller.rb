class HomeController < ApplicationController
  include CurrentCart
  before_action :set_current_cart, only: [:cart, :destroy_cart, :increase_quantity]
  before_action :check_general_user
  skip_before_action :check_general_user, only: [:index]

  def index
    if current_user.present? && current_user.is_admin?
      flash[:info] = "Welcome to Admin Panel #{current_user.user_name}"
      redirect_to admin_home_path
    else
      if session[:order_page] == true
        session[:order_page] = nil
        flash[:info] = "Place Order Now"
        redirect_to cart_path
      end
      if params[:category].present?
        @products = Product.where(available: true,product_category_id: params[:category])
      elsif params[:search_product].present?
        name = Product.arel_table[:name]
        @products = Product.where(available: true).where(name.matches("%#{params[:search_product]}%"))
      else
        @products = Product.where(available: true)
      end
    end
  end

  def product_details
    if params[:product_id].present?
      @product = Product.find(params[:product_id])
    else
      flash[:error] = "No product selected"
      redirect_to root_path
    end
  end

  def add_to_cart
    if params[:product_id].present?
      @quantity = params[:quantity].to_i
      if @quantity > 0
        set_current_cart
        @product = Product.find(params[:product_id])
        cart_item = @current_cart.cart_items.find_or_create_by(product: @product)
        cart_item.quantity += @quantity
        cart_item.save!
      end
    else
      flash[:error] = "Product could not be added to cart"
      redirect_to root_path
    end
  end

  def cart
  end

  def destroy_cart
    if @current_cart.destroy!
      session[:cart_id] = nil
      flash[:info] = "Cart is empty now!"
      redirect_to root_path
    else
      flash[:error] = "Could not empty the cart!"
      redirect_to root_path
    end
  end

  def destroy_cart_item
    cart_item = CartItem.find(params[:cart_item_id])
    if cart_item.destroy!
      redirect_to cart_path, notice: "Item removed from cart"
    else
      flash[:error] = "Item could not be removed from cart"
      redirect_to cart_path
    end
  end

  private


end
