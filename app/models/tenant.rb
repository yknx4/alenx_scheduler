class Tenant < ApplicationRecord
  validates_presence_of :subdomain
  has_many :users
  after_create :lease_apartment

  private
  def lease_apartment
    Apartment::Tenant.create(self.subdomain)
  end
end
