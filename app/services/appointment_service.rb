class AppointmentService < BaseAppointmentService
  include BizHelper
  include TenantHelper

  # start_time, end_time, provider, client
  def make_appointment(start_time, end_time)
    Appointment.create!(start_time: start_time, end_time: end_time, provider: provider, user: user)
  end

  def available_slots(start_time, end_time)
    available_schedules.each_with_object({}) do |schedule, hash|
      id = schedule[0]
      biz = schedule[1]
      hash[id] = periods_between biz, start_time, end_time
    end
  end

  def available_schedules
    available_slots_providers.each_with_object({}) do |provider, hash|
      breaks = appointments_as_breaks providers_appointment_dates(provider.id)

      provider_biz = provider.schedule.biz
      breaks_biz = biz_with_only_breaks(breaks)
      full_biz = tenant_biz & provider_biz & breaks_biz

      hash[provider.id] = full_biz
      hash
    end
  end

  def get_appointments(start_time = nil,
                       end_time = nil)
    raise TypeError, 'You must provide a User or a Provider' if user.blank? and provider.blank?

    records = appointments_query
    if start_time.present? and end_time.present?
      records = appointments_query.within(start_time, end_time)
    end

    records
  end

  def cancel_appointment(appointment_id)
    Appointment.find(appointment_id).destroy
  end

  private

  def appointments_query
    records = Appointment.all
    records = records.where(user_id: user.id) if user.present?
    records = records.where(provider_id: provider.id) if provider.present?
    records
  end

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
      start_time = appointment[0] - 1.minute
      end_time = appointment[1] + 1.minute
      start_date = start_time.to_date
      breaks[start_date] ||= {}
      breaks[start_date][start_time.to_s(:time)] = end_time.to_s(:time)
      breaks
    end
  end
end
