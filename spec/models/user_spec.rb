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
  end

end
