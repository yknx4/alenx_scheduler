module AppointmentServiceHelper
  def get_available_slots(options = {})
    user = options[:user]
    provider = options[:provider]
    services = options[:services]
    start_time = options[:start_time] || Time.current.beginning_of_day
    end_time = options[:end_time] || Time.current.end_of_day

    appointment_service = AppointmentService.new user: user, provider: provider, services: services
    appointment_service.available_slots start_time, end_time
  end
end
