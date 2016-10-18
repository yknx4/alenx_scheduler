class Tenant < ApplicationRecord
  validates_presence_of :subdomain
  validates_uniqueness_of :subdomain
  after_create :lease_apartment

  has_many :users
  has_one :organization

  def around_tenant
    current = Apartment::Tenant.current
    switch!
    yield
    Apartment::Tenant.switch!(current)
  end

  def switch!
    Apartment::Tenant.switch!(self.subdomain)
  end

  private
  def lease_apartment
    Apartment::Tenant.create(self.subdomain)
    around_tenant do
      Organization.create(tenant: self, name: self.subdomain)
    end
  end

end
