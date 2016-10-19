module RequiresSchedule
  extend ActiveSupport::Concern
  included do
    after_initialize :initialize_schedule
    after_create :save_schedule

    def save_schedule
      schedule.save unless schedule.persisted?
    end

    def initialize_schedule
      self.schedule ||= Schedule.new
    end

  end

  module ClassMethods

  end

end

