module UsersControllerHelper
  def user_update_params(id = 0)
    {
      id: id,
      user: {
        username: 'awesome'
      }
    }
  end
end
