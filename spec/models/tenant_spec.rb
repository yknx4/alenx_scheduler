require 'rails_helper'

RSpec.describe Tenant, type: :model do
  describe '#subdomain' do
    it 'should be invalid without subdomain' do
      tenant = create(:tenant)
      tenant.subdomain = nil
      expect(tenant.valid?).to be_falsey
    end
  end

  describe '#new' do
    it 'should create an organization' do
      tenant = create(:tenant)
      tenant.switch!
      expect(Organization.count).to eq 1
      expect(tenant.organization.present?).to be_truthy
    end
  end
end
