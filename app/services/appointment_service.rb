class AppointmentService < BaseAppointmentService

  # start_time, end_time, provider, client
  def make_appointment(start_time, end_time)
    raise TypeError.new('You must provide a User and a Provider') if user.blank? or provider.blank?
    Appointment.create!(start_time: start_time, end_time: end_time, provider: provider, user: user)
  end

  # def available_slots(start_time, end_time)
  # end

  def get_appointments(start_time=nil, end_time=nil)
    raise TypeError.new('You must provide a User or a Provider') if user.blank? and provider.blank?
    records = Appointment.all
    if user.present?
      records = records.where(user_id: user.id)
    end

    if provider.present?
      records = records.where(provider_id: provider.id)
    end

    if start_time.present?
      if end_time.present?
        records = records.where(start_time: start_time..end_time).or(records.where(end_time: start_time..end_time))
      else
        Rails.logger.warn 'You are getting appointments with a start_time but without an end_time'
      end
    end

    records
  end

  def cancel_appointment(appointment_id)
    Appointment.find(appointment_id).destroy
  end
end