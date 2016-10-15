FactoryGirl.define do
  factory :user do
    username              { Faker::Internet.user_name }
    email                 { Faker::Internet.email }
    password              "password"
    password_confirmation "password"
    role                  :user
  end

  factory :admin, parent: :user do
    role  :admin
  end

  factory :provider, parent: :user do
    role :provider
  end
end