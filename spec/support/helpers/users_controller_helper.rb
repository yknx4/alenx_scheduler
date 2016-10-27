module UsersControllerHelper
  def user_update_params(id = 0)
    {
      id: id,
      user: {
        username: 'awesome'
      }
    }
  end

  def update_role_params(id = 0)
    user_update_params(id).merge(user: { username: 'awesome', role: 'admin' })
  end
end
