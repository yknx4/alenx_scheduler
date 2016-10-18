class Organization < ApplicationRecord
  belongs_to :schedule
  belongs_to :tenant
  validate :only_one_organization
  private
  def only_one_organization
    if Organization.count >= 1
      errors[:base] << 'can only exists once per tenant'
    end
  end
end
