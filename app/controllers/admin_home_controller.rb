class AdminHomeController < ApplicationController

  before_action :set_order, only: [:set_order_status, :order_details]
  def index
    @category_count = ProductCategory.count
    @product_count_available = Product.where(available: true).count
    @product_count = Product.count
    @order_count = Order.count
    @to_be_completed_order_count = Order.Incomplete.count
  end

  def product_reviews
    @product = Product.find(params[:product_id])
    @ratings = @product.ratings
  end

  def manage_orders
    @orders = Order.all.order(created_at: :desc)
  end

  def order_details
  end

  def set_order_status
    if @order.set_order_status(params[:status].to_i)
      if params[:status] == '1'
        redirect_to manage_orders_path, notice: 'Marked as Completed'
      else
        redirect_to manage_orders_path, notice: 'Cancelled Successfully'
      end
    else
      flash[:error]="Could not be canceled"
      redirect_to manage_orders_path
    end
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end
end
