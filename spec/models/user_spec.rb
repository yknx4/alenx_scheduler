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

    context 'as user' do
      it 'should be invalid with services' do
        u = build(:user)
        u.services << build(:service)
        expect(u.valid?).to be_falsey
      end
    end

    context 'as provider' do
      it 'should be valid with services' do
        u = build(:stuffed_provider)
        expect(u.valid?).to be_truthy
      end

      it 'should be invalid without a schedule' do
        u = build(:provider, schedule: nil)
        expect(u.valid?).to be_falsey
      end
    end
  end

  describe '#new' do
    context 'as a provider' do
      it 'should create a default schedule' do
        u = build(:user)
        u.role = 'provider'
        u.save
        expect(u.schedule.present?).to be_truthy
      end
    end
  end

  describe '#admin?' do
    it 'should be admin when role admin is added' do
      u = create(:admin)
      expect(u.admin?).to be_truthy
    end

    it 'should be admin when role is set as admin' do
      u = build(:admin)
      expect(u.admin?).to be_truthy
    end
  end

  describe '#schedule' do
    context 'as provider' do
      it 'should have an schedule' do
        u = create(:provider)
        expect(u.schedule.present?).to be_truthy
        expect(Schedule.count).to eq 1
      end
    end
  end

end
