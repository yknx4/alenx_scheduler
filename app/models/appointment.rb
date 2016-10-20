class Appointment < ApplicationRecord
  validates_presence_of :user, :provider, :start_time, :end_time
  validate :star_date_cannot_be_later_than_end_time
  validate :should_not_overlap
  validate :should_be_on_same_day
  
  belongs_to :provider, class_name: 'User'
  belongs_to :user

  scope :within, ->(start_time, end_time) do
    where(start_time: start_time..end_time).or(where(end_time: start_time..end_time))
  end

  private
  def should_be_on_same_day
    if start_time and end_time
      unless start_time.to_date == end_time.to_date
        errors.add :start_time, 'should be same date as end_time'
      end
    end
  end

  def should_not_overlap
    if start_time and end_time and user and provider
      service = AppointmentService.new provider: self.provider
      overlaps = service.get_appointments(start_time, end_time).present?
      if overlaps
        errors.add :provider, "isn't available at that time"
      end
      service.provider = nil
      service.user = user
      overlaps = service.get_appointments(start_time, end_time).present?
      if overlaps
        errors.add :user, "isn't available at that time"
      end
    end
  end

  private
  def star_date_cannot_be_later_than_end_time
    if start_time > end_time
      errors.add :start_time, "can't be later than end time"
    end
  end
end
