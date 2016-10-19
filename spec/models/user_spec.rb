require 'rails_helper'

RSpec.describe User, type: :model do
  include_context 'default_tenant'

  describe '#roles' do
    it 'should have user role by default' do
      user = create(:user)
      expect(user.has_role?(:user)).to be_truthy
    end
  end

  describe '#subdomain' do

    it 'should return user subdomain if tenant is not present' do
      user = build(:user, tenant: nil, subdomain: 'subdomain')
      expect(user.subdomain).to eq 'subdomain'
    end

    it 'should return tenant subdomain if tenant is present' do
      user = build(:user, subdomain: 'subdomain')
      expect(user.subdomain).to eq tenant.subdomain
    end

  end

  describe '#valid' do
    it 'should be invalid without a subdomain nor tenant when it is a new record' do
      u = build(:user, tenant: nil)
      expect(u.valid?).to be_falsey
      expect(u.errors.details.as_json).to eq "subdomain" => [{"error" => 'blank'}], "tenant" => [{"error" => 'blank'}]
    end

    it 'should be invalid if the new user is an admin and the tenant already exists' do
      u = build(:admin, tenant: nil, subdomain: tenant.subdomain)
      expect(u.valid?).to be_falsey
      expect(u.errors.messages).to eq :tenant=>['already exists.']
    end

    context 'as user' do
      it 'should be invalid with services' do
        u = build(:user)
        u.services << build(:service)
        expect(u.valid?).to be_falsey
        expect(u.errors[:services].present?).to be_truthy
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
    before do
      Apartment::Tenant.reset
    end

    it 'should be admin when role admin is added' do
      u = create(:admin, subdomain: 'new')
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
        expect(u.schedule.persisted?).to be_truthy
      end
    end
  end

end
