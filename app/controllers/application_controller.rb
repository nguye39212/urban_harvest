class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name, :first_name, :last_name, :address_1, :address_2, :city, :zip_code, :state, :country, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role, :name, :first_name, :last_name, :address_1, :address_2, :city, :zip_code, :state, :country, :phone])

  end

end