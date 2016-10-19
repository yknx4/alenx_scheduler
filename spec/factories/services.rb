FactoryGirl.define do
  factory :service do
    tag { Faker::Superhero.power.parameterize }
  end
end
