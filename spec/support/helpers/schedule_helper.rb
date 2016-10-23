module ScheduleHelper
  def full_schedule
    Schedule.create! hours: full_biz_hours
  end

  def setup_full_schedule(element)
    element.schedule = full_schedule
    element.save!
  end

  def randomize_schedule(element)
    element.schedule = create(:schedule)
    element.save
  end

  def is_full_day_lapse?(lapse)
    current = Time.current
    (lapse.start_time == current.beginning_of_day) and (lapse.end_time == current.end_of_day)
  end

  def segments_includes_appointment?(appointment, *segments)
    segments.any? { |s| s.contains? appointment.start_time or s.contains? appointment.end_time }
  end

  def next_date(day)
    Time.current.utc.next_week.advance(days: day(day))
  end

  def day(name)
    {
      mon: 0,
      tue: 1,
      wed: 2,
      thu: 3,
      fri: 4,
      sat: 5,
      sun: 6
    }[name.to_sym]
  end

  def date_with_time(date, time)
    Time.zone = 'UTC'
    time = Time.zone.parse(time) if time.is_a? String
    date_in_datetime time, date
  end

  def date_in_datetime(datetime, date)
    datetime.to_datetime.change(year: date.year, month: date.month, day: date.day)
  end

  def schedule_dates(schedule)
    hours = schedule.hours
    hours.each_with_object({}) do |hour, hash|
      date = next_date(hour[0])
      times = hour[1..-1].map(&:to_a).map(&:flatten)
      times.each do |start_end_time|
        start_time = start_end_time[0]
        end_time = start_end_time[1]
        set_hash_dates start_time, end_time, date, hash
      end
    end
  end

  def set_hash_dates(start_time, end_time, date, hash)
    start_time = date_with_time date, start_time
    end_time = date_with_time date, end_time
    hash[start_time] = end_time
  end
end
