FactoryGirl.define do
  factory :user do
    username              { Faker::StarWars.character }
    email                 { Faker::Internet.email }
    password              'password'
    password_confirmation 'password'
    role                  'user'
  end

  factory :admin, parent: :user do
    role  'admin'
  end

  factory :incomplete_provider, parent: :user do
    role 'provider'
    schedule nil
  end

  factory :provider, parent: :incomplete_provider do
    after(:build) do |provider|
      provider.schedule = provider.tenant.schedule.dup
    end
  end

  factory :stuffed_provider, parent: :provider do
    services { [create(:service), create(:service), create(:service)] }
  end

  factory :provider_with_full_schedule, parent: :provider do
    association :schedule, factory: :full_schedule
  end
end
