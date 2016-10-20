# rubocop:disable Eval
module HasBizConcern
  def holidays
    super.map { |h| Date.parse(h) }
  end

  def hours
    return if super.nil?
    super.each_with_object({}) do |hour, new_hours|
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
    super.each_with_object({}) do |breakk, new_breaks|
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
      config.hours = hours
      config.breaks = breaks
      config.holidays = holidays
      config.time_zone = timezone
    end
  end
end
# rubocop:enable Eval
