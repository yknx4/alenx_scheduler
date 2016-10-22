module AppointmentHelper
  def random_appointments(max = 10)
    Array.new(rand(max)) do
      create(:appointment,
             start_time: Time.current.middle_of_day - rand(60).minutes,
             end_time: Time.current.middle_of_day + rand(60).minutes)
    end
  end
end
