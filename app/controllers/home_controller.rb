class HomeController < ApplicationController
  include CurrentCart
  before_action :set_current_cart, only: [:cart, :destroy_cart, :increase_quantity]

  def index
    if session[:order_page] == true
      session[:order_page] = nil
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

  def product_details
    if params[:product_id].present?
      @product = Product.find(params[:product_id])
    else
      redirect_to root_path, notice: "No product selected"
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
      redirect_to root_path, notice: "Product could not be added to cart"
    end
  end

  def cart
  end

  def destroy_cart
    if @current_cart.destroy!
      session[:cart_id] = nil
      redirect_to root_path, notice: "Cart is empty now!"
    else
      redirect_to root_path, notice: "Could not empty the cart!"
    end
  end

  def destroy_cart_item
    cart_item = CartItem.find(params[:cart_item_id])
    if cart_item.destroy!
      redirect_to cart_path, notice: "Item removed from cart"
    else
      redirect_to cart_path, notice: "Item could not be removed from cart"
    end
  end

  private


end
