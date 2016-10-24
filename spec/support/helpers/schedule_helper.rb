module ScheduleHelper
  def full_schedule
    Schedule.create! hours: full_biz_hours
  end

  def setup_full_schedule(element)
    element.schedule = full_schedule
    element.save!
  end

  def is_full_day_lapse?(lapse)
    current = Time.current
    (lapse.start_time == current.beginning_of_day) and (lapse.end_time == current.end_of_day)
  end

  def segments_includes_appointment?(appointment, *segments)
    segments.any? { |s| s.contains? appointment.start_time or s.contains? appointment.end_time }
  end
end
