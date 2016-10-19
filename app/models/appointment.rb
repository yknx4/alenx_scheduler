class Appointment < ApplicationRecord
  validates_presence_of :user, :provider, :start_time, :end_time
  validate :star_date_cannot_be_later_than_end_time
  validate :should_not_overlap
  
  belongs_to :provider, class_name: 'User'
  belongs_to :user

  private
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
