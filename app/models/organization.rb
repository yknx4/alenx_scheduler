class Organization < ApplicationRecord
  belongs_to :schedule
  belongs_to :tenant
  validate :only_one_organization
  validates_presence_of :schedule

  after_initialize :initialize_schedule
  after_create :save_schedule

  private
  def save_schedule
    schedule.save unless schedule.persisted?
  end

  def initialize_schedule
    self.schedule ||= Schedule.new
  end

  def only_one_organization
    if Organization.count >= 1
      errors[:base] << 'can only exists once per tenant'
    end
  end
end
