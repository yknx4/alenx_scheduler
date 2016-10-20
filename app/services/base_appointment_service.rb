class BaseAppointmentService
  attr_accessor :provider, :services, :user, :appointment_id

  def initialize(options = {})
    @options = options
    load_from_options :provider, :services, :user
  end

  def make_appointment(_start_time, _end_time)
    raise NotImplementedError
  end

  def available_slots(_start_time, _end_time)
    raise NotImplementedError
  end

  def get_appointments(_start_time = nil, _end_time = nil)
    raise NotImplementedError
  end

  def cancel_appointment(_appointment_id)
    raise NotImplementedError
  end

  private

  def load_from_options(*options)
    options.each do |name|
      setter = "#{name}=".to_sym
      value = @options[name]
      send(setter, value)
    end
  end
end
