FactoryGirl.define do
  factory :organization do
    name { Faker::Company.name }
    schedule
  end
end
