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

  def user_create_params
    {
      user: {
        username:              Faker::StarWars.character.parameterize,
        email:                 Faker::Internet.email,
        password:              'password',
        password_confirmation: 'password'
      }
    }
  end
end
