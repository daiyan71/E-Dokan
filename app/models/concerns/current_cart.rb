module CurrentCart

  private
  def set_current_cart
    if session[:cart_id].present?
      @current_cart = Cart.find(session[:cart_id])
    else
      @current_cart = Cart.create()
      if current_user.present?
        @current_cart.user = current_user
        @current_cart.save!
      end
      session[:cart_id] = @current_cart.id
    end
  end
end