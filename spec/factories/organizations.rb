FactoryGirl.define do
  factory :organization do
    name { Faker::StarWars.planet }
    schedule
  end
end
