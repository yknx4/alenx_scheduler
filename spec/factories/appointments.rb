FactoryGirl.define do
  sequence :start_time do |n|
    Time.current.beginning_of_day + (n * 16).minutes
  end

  sequence :end_time do |n|
    Time.current.beginning_of_day + 15.minutes + (n * 16).minutes
  end

  factory :appointment do
    start_time
    end_time
    association :provider, factory: :provider_with_full_schedule
    user
  end
end
