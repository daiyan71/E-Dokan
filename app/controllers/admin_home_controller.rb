class AdminHomeController < ApplicationController

  def index
    @category_count = ProductCategory.count
    @product_count_available = Product.where(available: true).count
    @product_count = Product.count
    @order_count = Order.count
  end

  def product_reviews
    @product = Product.find(params[:product_id])
    @ratings = @product.ratings
  end

end
