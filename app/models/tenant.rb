class Tenant < ApplicationRecord
  validates_presence_of :subdomain
  validates_uniqueness_of :subdomain
  after_create :lease_apartment

  has_many :users

  private
  def lease_apartment
    Apartment::Tenant.create(self.subdomain)
  end
end
