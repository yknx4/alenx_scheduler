class AppointmentService < BaseAppointmentService
  include BizHelper

  # start_time, end_time, provider, client
  def make_appointment(start_time, end_time)
    raise TypeError, 'You must provide a User and a Provider' if user.blank? || provider.blank?
    Appointment.create!(start_time: start_time, end_time: end_time, provider: provider, user: user)
  end

  def available_slots(start_time, end_time)
    tenant_biz = Tenant.current.organization.schedule.biz

    available_slots_providers.each_with_object({}) do |provider, hash|
      provider_appointments = providers_appointment_dates provider.id
      breaks = appointments_as_breaks provider_appointments

      provider_biz = provider.schedule.biz
      breaks_biz = biz_with_only_breaks(breaks)
      full_biz = tenant_biz & provider_biz & breaks_biz

      hash[provider.id] = full_biz.periods.after(start_time).timeline.until(end_time).to_a
      hash
    end
  end

  def get_appointments(start_time = nil,
                       end_time = nil)
    raise TypeError, 'You must provide a User or a Provider' if user.blank? && provider.blank?
    records = Appointment.all
    records = records.where(user_id: user.id) if user.present?

    records = records.where(provider_id: provider.id) if provider.present?

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

  private

  def available_slots_providers
    providers = User.providers

    providers = providers.where(id: provider.id) if provider.present?

    if services.present?
      providers = providers.joins(:services).merge(Service.where(id: services))
    end

    providers
  end

  def providers_appointment_dates(provider_id)
    providers_appointments = Appointment.joins(:provider).merge(available_slots_providers)
    @providers_appointment_dates ||= providers_appointments.each_with_object({}) do |appointment, hash|
      hash[appointment.provider_id] ||= []
      hash[appointment.provider_id].push [appointment.start_time, appointment.end_time]
      hash
    end

    @providers_appointment_dates[provider_id] || []
  end

  def appointments_as_breaks(appointments)
    appointments.each_with_object({}) do |appointment, breaks|
      start_time = appointment[0]
      end_time = appointment[1]
      start_date = start_time.to_date
      breaks[start_date] ||= {}
      breaks[start_date][start_time.to_s(:time)] = end_time.to_s(:time)
      breaks
    end
  end
end
