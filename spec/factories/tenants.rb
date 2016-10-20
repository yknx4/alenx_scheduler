FactoryGirl.define do
  factory :tenant do
    subdomain { Faker::Internet.domain_word }
  end
end
