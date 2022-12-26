class ApplicationController < ActionController::Base
  add_flash_types :info
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :image, :contact_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :image, :contact_number])
  end

  def check_general_user
    if current_user.present? && current_user.is_admin?
      flash[:error] = "This page is only for general user"
      redirect_to admin_home_path
    end
  end
end
