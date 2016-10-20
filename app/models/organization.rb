class Organization < ApplicationRecord
  include RequiresSchedule

  belongs_to :schedule
  belongs_to :tenant
  validate :only_one_organization
  validates_presence_of :schedule

  private

  def only_one_organization
    if new_record? && (Organization.count >= 1)
      errors[:base] << 'can only exists once per tenant'
    end
  end
end
