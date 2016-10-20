require 'rails_helper'
include Rails.application.routes.url_helpers

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
  include_context 'default_tenant'

  describe '#create' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    context 'with subdomain' do
      it 'should create a user' do
        params = default_user_params(tenant.subdomain)
        post :create, params: params
        expect(User.users.count).to eq 1
        expect(subject).to redirect_to user_url(User.last, subdomain: tenant.subdomain)
      end
    end

    context 'without subdomain' do
      before do
        Apartment::Tenant.reset
        request.host = 'www.example.com'
      end

      it 'should create an admin' do
        params = default_admin_params
        post :create, params: params
        expect(User.admins.count).to eq 1
        expect(Tenant.where(subdomain: params[:user][:subdomain]).exists?).to be_truthy
        expect(Tenant.current).to eq Tenant.last
        expect(response.location).to eq(new_user_session_url(subdomain: Tenant.last.subdomain))
        expect(subject).to redirect_to new_user_session_url(subdomain: Tenant.last.subdomain)
      end
    end
  end
end
