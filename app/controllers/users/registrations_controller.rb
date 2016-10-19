class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper
  before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    params[:user][:role] = 'admin' if without_tenant?
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def extra_sign_up_params
    if without_tenant?
      [:subdomain, :role]
    else
      [:subdomain]
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: extra_sign_up_params)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    if without_tenant?
      sign_out resource
      new_user_session_url(subdomain: resource.subdomain)
    else
      stored_location_for(resource) || url_for(resource) || root_path
      # super(resource)
    end
  end

  def after_sign_in_path_for(resource)
    # super(resource)
    stored_location_for(resource) || url_for(resource) || root_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

end
