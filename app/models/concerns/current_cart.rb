module CurrentCart

  private
  def set_current_cart
    if session[:cart_id].present?
      @current_cart = Cart.find(session[:cart_id])
    else
      @current_cart = Cart.create()
      session[:cart_id] = @current_cart.id
    end
    if @current_cart&.cart_items&.empty? && current_user&.cart&.present?
      @current_cart = current_user.cart
      session[:cart_id] = current_user.cart.id
    end
    if @current_cart.user.nil? && current_user.present?
      current_user&.cart&.destroy!
      @current_cart.user = current_user
      @current_cart.save!
    end
  end

  def get_current_cart
    if session[:cart_id].present?
      @current_cart = Cart.find(session[:cart_id])
    else
      @current_cart = nil
    end
    @current_cart
  end
end