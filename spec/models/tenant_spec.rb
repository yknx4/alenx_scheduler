require 'rails_helper'

RSpec.describe Tenant, type: :model do
  describe '#subdomain' do
    it 'should be invalid without subdomain' do
      tenant = create(:tenant)
      tenant.subdomain = nil
      expect(tenant.valid?).to be_falsey
    end
  end
end
