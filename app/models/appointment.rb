class Appointment < ApplicationRecord
  validates :user, :provider, :start_time, :end_time, presence: true
  validate :start_date_cannot_be_later_than_end_time
  validate :should_not_overlap
  validate :in_tenant_range
  validate :in_provider_range

  belongs_to :provider, class_name: 'User'
  belongs_to :user

  scope :within, ->(start_time, end_time) do
    where(start_time: start_time..end_time).or(where(end_time: start_time..end_time))
  end

  private

  def in_tenant_range
    in_biz_range Tenant.current
  end

  def in_provider_range
    return if provider.blank?
    in_biz_range provider
  end

  def in_biz_range(element)
    biz = element.schedule.biz
    message = "is outside #{(element.model_name.element)} schedule"
    errors.add(:start_time, message) unless biz.in_hours? start_time
    errors.add(:end_time, message) unless biz.in_hours? end_time
  end

  def should_not_overlap
    return unless errors.blank?
    errors.add :provider, "isn't available at that time" if provider_overlaps?
    errors.add :user, "isn't available at that time" if user_overlaps?
  end

  def user_overlaps?
    service = AppointmentService.new user: user
    service.get_appointments(start_time, end_time).present?
  end

  def provider_overlaps?
    service = AppointmentService.new provider: provider
    service.get_appointments(start_time, end_time).present?
  end

  def start_date_cannot_be_later_than_end_time
    return unless start_time > end_time
    errors.add :start_time, "can't be later than end time"
  end
end
