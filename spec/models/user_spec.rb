require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#roles' do
    it 'should have user role by default' do
      user = create(:user)
      expect(user.has_role?(:user)).to be_truthy
    end
  end

  describe '#valid' do
    it 'should be invalid without a subdomain nor tenant when it is a new record' do
      u = build(:user, tenant: nil)
      expect(u.valid?).to be_falsey
      expect(u.errors.details.as_json).to eq "subdomain" => [{"error" => 'blank'}], "tenant" => [{"error" => 'blank'}]
    end

    it 'should be invalid if the new user is an admin and the tenant already exists' do
      tenant = create(:tenant)
      u = build(:admin, tenant: nil, subdomain: tenant.subdomain)
      expect(u.valid?).to be_falsey
      expect(u.errors.messages).to eq :tenant=>['already exists.']
    end
  end

end
