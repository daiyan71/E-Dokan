class ChargesController < ApplicationController
  rescue_from Stripe::CardError, with: :catch_exception
  before_action :check_general_user
  def new
  end

  def create
    StripeChargesServices.new(charges_params, current_user).call
    redirect_to orders_path, notice: "Payment Process Completed"
  end

  private

  def charges_params
    params.permit(:stripeEmail, :stripeToken, :order_id)
  end

  def catch_exception(exception)
    flash[:error] = exception.message
  end
end