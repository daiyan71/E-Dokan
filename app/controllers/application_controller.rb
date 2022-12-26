class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :image, :contact_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :image, :contact_number])
  end

  def check_general_user
    if current_user.present? && current_user.is_admin?
      redirect_to admin_home_path, alert: "This site is for general user"
    end
  end
end
