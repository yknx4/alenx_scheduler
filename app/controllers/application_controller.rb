class ApplicationController < ActionController::Base
  include ApplicationHelper
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_as_admin, if: :without_tenant?, only: [:create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: extra_sign_up_params)
  end

  def extra_sign_up_params
    if without_tenant?
      [:subdomain, :username, :role]
    else
      [:subdomain, :username]
    end
  end

  def set_user_as_admin
    if params[:user].present?
      params[:user][:role] = 'admin'
    else
      params[:role] = 'admin'
    end
  end
end
