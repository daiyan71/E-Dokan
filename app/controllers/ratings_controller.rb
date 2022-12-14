class RatingsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]
  before_action :check_general_user
  def new
    unless params[:product_id].present?
      flash[:error] = "You Don't have access!"
      redirect_to root_path
    else
      @product = Product.find(params[:product_id])
      @ratings = @product.ratings
      if current_user.present?
        @rating = Rating.find_by(product: @product, user: current_user)
        if @rating.nil?
          @rating = Rating.new
        else
          @rating_id = @rating.id
        end
      end
    end
  end

  def create
    @rating = Rating.new(rating_params)
    @rating.user = current_user
    if @rating.save
      redirect_to new_rating_path(product_id: @rating.product_id), notice: "Rating Successfull"
    else
      flash[:error] = "Failed!"
      redirect_to new_rating_path(product_id: @rating.product_id)
    end
  end

  def update
    @rating = Rating.find(params[:rating_id])
    puts params[:product_id]
    if @rating.update(rating_params)
      redirect_to new_rating_path(product_id: @rating.product_id), notice: "Rating Updated"
    else
      flash[:error] = "Failed"
      redirect_to new_rating_path(product_id: @rating.product_id)
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:rating, :message, :product_id)
  end
end
