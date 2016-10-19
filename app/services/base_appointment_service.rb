class BaseAppointmentService
  attr_accessor :provider, :services, :user, :appointment_id

  def initialize(options={})
    @options = options
    load_from_options :provider, :services, :user
  end

  def make_appointment(start_time, end_time)
    raise NotImplementedError
  end

  def available_slots(start_time, end_time)
    raise NotImplementedError
  end

  def get_appointments(start_time=nil, end_time=nil)
    raise NotImplementedError
  end

  def cancel_appointment(appointment_id)
    raise NotImplementedError
  end

  private
  def load_from_options(*options)
    options.each do |name|
      setter = "#{name.to_s}=".to_sym
      value = @options[name]
      send(setter, value)
    end
  end
end