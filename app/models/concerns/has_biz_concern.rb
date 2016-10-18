module HasBizConcern
  def holidays
    super.map{|h| Date.parse(h)}
  end

  def hours
    return if super.nil?
    super.inject({}) do |new_hours, hour|
      if hour.present?
        key = hour[0].to_sym
        raw_value = hour[1]
        value = eval(raw_value) if raw_value.include?('{') and raw_value.include?('}')
        new_hours[key] = value
      end
      new_hours
    end
  end

  def breaks
    return if super.nil?
    super.inject({}) do |new_breaks, breakk|
      if breakk.present?
        key = Date.parse(breakk[0])
        raw_value = breakk[1]
        value = eval(raw_value) if raw_value.include?('{') and raw_value.include?('}')
        new_breaks[key] = value
      end
      new_breaks
    end
  end

  def biz
    Biz.configure do |config|
      config.hours = self.hours
      config.breaks = self.breaks
      config.holidays = self.holidays
      config.time_zone = self.timezone
    end
  end
end