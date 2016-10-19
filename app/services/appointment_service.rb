class AppointmentService < BaseAppointmentService

  # start_time, end_time, provider, client
  def make_appointment(start_time, end_time)
    Appointment.create(start_time: start_time, end_time: end_time, provider: provider, user: user)
  end

  # def available_slots(start_time, end_time)
  # end

  def get_appointments
    raise TypeError if user.blank? and provider.blank?
    base = Appointment
    if user.present?
      base = base.where(user_id: user.id)
    end

    if provider.present?
      base = base.where(provider_id: provider.id)
    end

    base
  end

  def cancel_appointment(appointment_id)
    Appointment.find(appointment_id).destroy
  end
end