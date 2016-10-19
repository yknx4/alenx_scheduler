FactoryGirl.define do
  factory :appointment do
    start_time { Time.now }
    end_time { 15.minutes.from_now }
    provider
    user
  end
end
