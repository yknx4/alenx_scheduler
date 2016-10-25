module RegistrationsHelper
  def default_user_params(subdomain = nil)
    {
        user: {
            email: Faker::Internet.email,
            username: Faker::Internet.user_name,
            password: 'password',
            password_confirmation: 'password',
            subdomain: subdomain
        }
    }
  end

  def default_api_sign_up_params(subdomain = nil)
    {
        email: Faker::Internet.email,
        password: 'password',
        password_confirmation: 'password',
        subdomain: subdomain,
        confirm_success_url: "#{subdomain}.example.com/success"
    }
  end

  def default_admin_params
    default_user_params(Faker::Internet.domain_word)
  end

  def default_api_admin_params
    default_api_sign_up_params(Faker::Internet.domain_word)
  end
end