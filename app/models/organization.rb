class Organization < ApplicationRecord
  include RequiresSchedule

  belongs_to :schedule
  belongs_to :tenant
  validate :only_one_organization
  validates :schedule, presence: true

  private

  def only_one_organization
    return unless new_record? && (Organization.count >= 1)
    errors[:base] << 'can only exists once per tenant'
  end
end
