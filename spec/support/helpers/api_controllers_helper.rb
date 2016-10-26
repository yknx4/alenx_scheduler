module ApiControllersHelper
  def token(user)
    user.create_new_auth_token
  end

  def api_authorize_user(user)
    request.headers.merge! token(user)
  end
end
