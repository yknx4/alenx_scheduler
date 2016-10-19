FactoryGirl.define do
  factory :user do
    tenant
    username              { Faker::StarWars.character }
    email                 { Faker::Internet.email }
    password              'password'
    password_confirmation 'password'
    role                  'user'
  end

  factory :admin, parent: :user do
    role  'admin'
  end

  factory :provider, parent: :user do
    role 'provider'
    schedule
  end

  factory :stuffed_provider, parent: :provider do
    services { [create(:service), create(:service), create(:service)] }
  end
end