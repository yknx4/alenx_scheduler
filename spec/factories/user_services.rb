FactoryGirl.define do
  factory :user_service do
    association :user, factory: :provider
    service
  end
end
