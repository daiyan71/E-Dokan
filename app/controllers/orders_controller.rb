class OrdersController < ApplicationController
  include CurrentCart
  before_action :verify_cart, only: [:new, :create]
  before_action :set_order, only: [:payment]
  def new
    @order = Order.new
  end

  def create
    order = Order.new(order_params)
    ActiveRecord::Base.transaction do
      order.user = current_user
      order.payment_status = Order::UNPAID
      order.total_amount = @current_cart.total_amount
      order.save
      order_items = []
      @current_cart.cart_items.each do |cart_item|
        order_items << OrderItem.new(
            product: cart_item.product,
            quantity: cart_item.quantity,
            unit_price: cart_item.product.price,
            total_price: cart_item.product.price*cart_item.quantity
        )

      end
      order.order_items = order_items
    end

    if order.save!
      redirect_to payment_order_path(order), notice: "Order Placed. Please Pay Now"
    else
      redirect_to new_order_path, notice: "Could not place the order, please try again"
    end
  end

  def payment
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
  def verify_cart
    get_current_cart
    if @current_cart.nil?
      redirect_to root_path, notice: "EMpty Cart"
    end
  end
end
