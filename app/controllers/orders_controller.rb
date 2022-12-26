class OrdersController < ApplicationController
  include CurrentCart
  before_action :verify_user_and_cart, only: [:new, :create]
  before_action :set_order, only: [:payment, :destroy, :show]
  before_action :check_user, only: [:index]
  before_action :check_general_user

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    ActiveRecord::Base.transaction do
      @order.user = current_user
      @order.payment_status = Order::UNPAID
      @order.total_amount = @current_cart.total_amount
      @order.save
      order_items = []
      @current_cart.cart_items.each do |cart_item|
        order_items << OrderItem.new(
            product: cart_item.product,
            quantity: cart_item.quantity,
            unit_price: cart_item.product.price,
            total_price: cart_item.product.price*cart_item.quantity
        )

      end
      @order.order_items = order_items
    end

    if @order.save
      ReceiptMailer.send_receipt(current_user, @order).deliver_later
      @current_cart.destroy!
      session[:cart_id] = nil
      redirect_to payment_order_path(@order), notice: "Order Placed. Please Pay Now"
    else
      render :new
    end
  end

  def show
  end

  def payment
    unless @order.Unpaid?
      redirect_to orders_path, alert: "Payment Process already Completed"
    end
  end

  def destroy
    unless @order.Unpaid?
      redirect_to orders_path, alert: "Can not be canceled"
    else
      @order.destroy
      redirect_to orders_path, notice: "Canceled Successfully"
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:name, :contact_number, :address, :total_amount
    )
  end
  def verify_user_and_cart
    get_current_cart
    if @current_cart.nil?
      redirect_to root_path, alert: "Empty Cart"
    end
    unless current_user.present?
      session[:order_page] = true
      redirect_to new_user_session_path, alert: "Sign in first"
    end
  end
  def check_user
    unless current_user.present?
      flash[:error] = "You Don't have access!"
      redirect_to root_path
    end
  end
end
