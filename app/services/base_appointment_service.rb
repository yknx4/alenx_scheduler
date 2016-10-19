class AppointmentService
  def make_appointment(start_time, end_time, provider, client)
    raise NotImplementedError
  end

  def available_slots(start_time, end_time, services, provider)
    raise NotImplementedError
  end

  def get_appointments(user, provider)
    raise NotImplementedError
  end

  def cancel_appointment(appointment_id)
    raise NotImplementedError
  end
end