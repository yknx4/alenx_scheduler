module ApiControllersHelper
  def token(user)
    user.create_new_auth_token
  end

  def api_authorize_user(user)
    request.headers.merge! token(user)
  end

  def response_object
    JSON.parse(response.body)
  end

  def expect_forbidden
    expect(response).to have_http_status(:forbidden)
  end
end
