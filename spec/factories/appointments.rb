FactoryGirl.define do

  sequence :start_time do |n|
    (n * 2).hours.from_now - rand(60).minutes
  end

  sequence :end_time do |n|
    (n * 2).hours.from_now + rand(60).minutes
  end

  factory :appointment do
    start_time
    end_time
    provider
    user
  end
end
