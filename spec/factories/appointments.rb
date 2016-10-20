FactoryGirl.define do

  sequence :start_time do |n|
    n.days.from_now.middle_of_day - rand(60).minutes
  end

  sequence :end_time do |n|
    n.days.from_now.middle_of_day + rand(60).minutes
  end

  factory :appointment do
    start_time
    end_time
    provider
    user
  end
end
