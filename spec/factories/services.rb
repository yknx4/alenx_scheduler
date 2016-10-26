FactoryGirl.define do
  factory :service do
    sequence(:tag) { |n| "#{Faker::Superhero.power.parameterize}#{n}" }
  end
end
