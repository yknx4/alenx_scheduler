require 'rails_helper'

RSpec.describe User, type: :model do
  include_context 'default_tenant'

  describe '#roles' do
    it 'should have user role by default' do
      user = create(:user)
      expect(user).to have_role :user
      expect(user).to be_user
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
      expect(u).to be_invalid
      expect(u.errors).to have_key :subdomain
      expect(u.errors).to have_key :tenant
    end

    it 'should be invalid if the new user is an admin and the tenant already exists' do
      u = build(:admin, tenant: nil, subdomain: tenant.subdomain)
      expect(u).to be_invalid
      expect(u.errors).to have_key :tenant
    end

    it 'should be invalid if the tenant is not active' do
      u = build(:user)
      Apartment::Tenant.reset
      expect(u).to be_invalid
      expect(u.errors).to have_key :tenant
      expect(u.errors[:tenant]).to include 'has to be active'
    end

    context 'as user' do
      it 'should be invalid with services' do
        u = build(:user)
        u.services << build(:service)
        expect(u).to be_invalid
        expect(u.errors).to have_key :services
      end
    end

    context 'as provider' do
      it 'should be valid with services' do
        u = build(:stuffed_provider)
        expect(u).to be_valid
      end

      it 'should be invalid without a schedule' do
        u = build(:incomplete_provider)
        expect(u).to be_invalid
      end
    end
  end

  describe '#new' do
    context 'as a provider' do
      it 'should create a default schedule' do
        u = build(:user)
        u.role = 'provider'
        u.save!
        expect(u.schedule).to be_present
      end
    end

    it 'should set tenant to current tenant by default' do
      u = User.new
      expect(u.tenant).to eq tenant
    end
  end

  describe '#admin?' do
    before do
      Apartment::Tenant.reset
    end

    it 'should be admin when role admin is added' do
      u = create(:admin, subdomain: 'new')
      expect(u).to be_admin
    end

    it 'should be admin when role is set as admin' do
      u = build(:admin)
      expect(u).to be_admin
    end
  end

  describe '#schedule' do
    context 'as provider' do
      it 'should have an schedule' do
        u = create(:provider)
        expect(u.schedule).to be_present
        expect(u.schedule).to be_persisted
      end
    end
  end
end
