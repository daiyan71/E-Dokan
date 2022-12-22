class OrdersController < ApplicationController
  include CurrentCart
  before_action :verify_cart, only: [:new, :create]
  before_action :set_order, only: [:payment]
  def new
    @order = Order.new
  end

  def create
    ActiveRecord::Base.transaction do
      @order = Order.new(order_params)
      @order.user = current_user
      @order.payment_status = Order::UNPAID
      @order.total_amount = @current_cart.total_amount
      @order.save
      @current_cart.cart_items.each do |cart_item|
        @order.order_items.create(
            product: cart_item.product,
            quantity: cart_item.quantity,
            unit_price: cart_item.product.price,
            total_price: cart_item.product.price*cart_item.quantity
        )

      end
    end

    redirect_to payment_order_path(@order)
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
