class HomeController < ApplicationController
  include CurrentCart
  before_action :set_current_cart, only: [:cart, :destroy_cart, :increase_quantity]
  before_action :check_general_user
  skip_before_action :check_general_user, only: [:index, :all_products]

  def index
    if current_user.present? && current_user.is_admin?
      flash[:info] = "Welcome to Admin Panel #{current_user.user_name}"
      redirect_to admin_home_path
    else
      @featured_products = Product.where(available: true, featured: true).limit(8)
      @top_rated_products = Product.where(available: true).order(current_rating: :desc).limit(8)
      sql = "select product_id, count(product_id) from order_items group by product_id order by count(product_id) desc"
      popular_product_ids = OrderItem.find_by_sql(sql).pluck(:product_id)
      @popular_products = Product.where(available: true, id: popular_product_ids).limit(8)
      @products = Product.where(available: true)
    end
  end

  def all_products
    if params[:category].present?
      @products = Product.where(available: true,product_category_id: params[:category])
    elsif params[:search_product].present?
      name = Product.arel_table[:name]
      @products = Product.where(available: true).where(name.matches("%#{params[:search_product]}%"))
    elsif params[:filter].present?
      filter = params[:filter]
      session[:filter] = {}
      @products = Product.where(available: true)
      unless filter[:category] == ''
        session[:filter]['category'] = filter[:category]
        @products = @products.where(product_category_id: filter[:category])
      end
      unless filter[:min_price] == ''
        session[:filter]['min_price'] = filter[:min_price]
        @products = @products.where("price >= ?", filter[:min_price])
      end
      unless filter[:max_price] == ''
        session[:filter]['max_price'] = filter[:max_price]
        @products = @products.where("price <= ?", filter[:max_price])
      end
      unless filter[:search] == ''
        session[:filter]['search'] = filter[:search]
        name = Product.arel_table[:name]
        @products = @products.where(name.matches("%#{filter[:search]}%"))
      end
    else
      session[:filter] = {}
      @products = Product.where(available: true)
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
