FactoryGirl.define do
  factory :appointment do
    start_time { rand(60).minutes.ago }
    end_time { rand(60).minutes.from_now }
    provider
    user
  end
end
