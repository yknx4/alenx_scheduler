class Organization < ApplicationRecord
  include RequiresSchedule

  belongs_to :schedule
  belongs_to :tenant
  validate :only_one_organization
  validates :schedule, presence: true

  delegate :biz, to: :schedule

  private

  def only_one_organization
    return unless new_record? and (Organization.count >= 1)
    errors[:base] << 'can only exists once per tenant'
  end
end
