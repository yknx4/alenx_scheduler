module BizHelper
  def biz_with_only_breaks(breaks, timezone = nil)
    timezone ||= Time.zone.tzinfo.name
    Biz::Schedule.new do |config|
      config.hours = full_biz_hours

      config.breaks = breaks

      config.holidays = []

      config.time_zone = timezone
    end
  end

  def full_biz_hours
    {
      mon: { '00:00' => '24:00' },
      tue: { '00:00' => '24:00' },
      wed: { '00:00' => '24:00' },
      thu: { '00:00' => '24:00' },
      fri: { '00:00' => '24:00' },
      sat: { '00:00' => '24:00' },
      sun: { '00:00' => '24:00' }
    }
  end

  def periods_between(biz, start_time, end_time)
    biz.periods.after(start_time).timeline.until(end_time).to_a
  end

  def merge_biz(*biz)
    biz.reduce(&:&)
  rescue
    nil
  end
end
