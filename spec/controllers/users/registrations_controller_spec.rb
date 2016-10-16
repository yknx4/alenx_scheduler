require 'rails_helper'

def default_user_params(subdomain = nil)
  {
      user: {
          email: Faker::Internet.email,
          username: Faker::Internet.user_name,
          password: 'password',
          password_confirmation: 'password',
          subdomain: subdomain
      }
  }
end

def default_admin_params
  default_user_params(Faker::Internet.domain_word)
end

RSpec.describe Users::RegistrationsController, type: :controller do
  describe '#create' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    context 'with subdomain' do
      let(:tenant) { create(:tenant) }
      before do
        request.host = "#{tenant.subdomain}.example.com"
      end

      it 'should create a user' do
        params = default_user_params(tenant.subdomain)
        post :create, params
        expect(User.users.count).to eq 1
      end
    end

    context 'without subdomain' do
      before do
        request.host = 'www.example.com'
      end

      it 'should create an admin' do
        params = default_admin_params
        post :create, params
        expect(User.admins.count).to eq 1
        expect(Tenant.count).to eq 1
      end
    end
  end
end
