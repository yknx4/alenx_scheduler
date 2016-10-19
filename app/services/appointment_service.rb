class AppointmentService < BaseAppointmentService

  # start_time, end_time, provider, client
  def make_appointment(start_time, end_time)
    raise TypeError.new('You must provide a User and a Provider') if user.blank? or provider.blank?
    Appointment.create!(start_time: start_time, end_time: end_time, provider: provider, user: user)
  end

  def available_slots(start_time, end_time)
    providers = User.providers
    tenant_schedule = Tenant.current.organization.schedule.biz

    if provider.present?
      providers = providers.where(provider_id: provider.id)
    end

    if services.present?
      providers = providers.joins(:services).merge(Service.where(id: services))
    end

    appointments = Appointment.where(provider_id: providers.pluck(:id)).inject({}) do |hash, appointment|
      hash[appointment.provider_id] ||= []
      hash[appointment.provider_id].push [appointment.start_time, appointment.end_time]
      hash
    end

    slots = {}

    providers.each do |provider|
      final_schedule = provider.schedule.biz & tenant_schedule
      provider_appointments = appointments[provider.id] || []

      provider_appointments.each do |provider_appointment|
        start_time = provider_appointment[0]
        end_time = provider_appointment[1]
        start_date = start_time.to_date
        end_date = end_time.to_date
        if start_date == end_date
          current_break = final_schedule.breaks
        else

        end
      end

    end


  end

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
        records = records.within(start_time, end_time)
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