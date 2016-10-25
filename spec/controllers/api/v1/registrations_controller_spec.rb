require 'rails_helper'

RSpec.describe DeviseTokenAuth::RegistrationsController, type: :controller do
  include_context 'default_tenant'
  include RegistrationsHelper

  describe '#create' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    context 'with subdomain' do
      it 'should create a user' do
        params = default_api_sign_up_params(tenant.subdomain)
        post :create, params: params
        body = JSON.parse(response.body)
        expect(body['status']).to eq 'success'
        expect(User.users.count).to eq 1
      end
    end

    context 'without subdomain' do
      before do
        Apartment::Tenant.reset
        request.host = 'www.example.com'
      end

      it 'should create an admin' do
        params = default_api_admin_params
        post :create, params: params
        body = JSON.parse(response.body)
        expect(body['status']).to eq 'success'
        expect(User.admins.count).to eq 1
        expect(Tenant.where(subdomain: params[:subdomain])).to exist
        expect(Tenant.current).to eq Tenant.last
      end
    end
  end
end
