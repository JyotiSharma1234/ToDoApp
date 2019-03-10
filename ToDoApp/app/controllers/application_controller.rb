class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_current_user
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address])
  end

  def load_current_user
  	@current_user = current_user
  end
end
