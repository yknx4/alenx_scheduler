module AppointmentHelper
  def random_appointments(max = 10)
    Array.new(rand(max)) do
      create(:appointment)
    end
  end

  def sequencial_appointment(base_time = nil)
    @sequence ||= 0
    @sequence += 1
    base_time ||= Time.current.beginning_of_day

    start_time = base_time + (@sequence * 16).minutes
    end_time = base_time + 15.minutes + (@sequence * 16).minutes

    @sequence += 1

    create :appointment, start_time: start_time, end_time: end_time
  end
end
