module ScheduleHelper
  def full_schedule
    Schedule.create! hours: full_biz_hours
  end

  def setup_full_schedule(element)
    element.schedule = full_schedule
    element.save!
  end

  def is_full_day_lapse?(lapse)
    current = Time.current.utc
    (lapse.start_time == current.beginning_of_day) and (lapse.end_time == current.end_of_day)
  end
end
