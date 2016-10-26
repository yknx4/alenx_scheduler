require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  include_context 'default_tenant'
  include ApiControllersHelper
  let(:admin) { create :admin }
  let(:user) { create :user }

  describe '#show' do
    it 'should show current user' do
      api_authorize_user admin
      get :show, params: { id: admin.id }

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(body).to have_key 'data'
      expect(body['data']).to be_a Hash
    end

    it 'should show another user' do
      api_authorize_user admin
      get :show, params: { id: user.id }

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(body).to have_key 'data'
      expect(body['data']).to be_a Hash
    end
  end

  context 'as admin' do
    describe '#index' do
      it 'should show all users' do
        rand(20).times { create :user }

        api_authorize_user admin
        get :index

        body = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(body).to have_key 'data'
        expect(body['data'].count).to be_positive
        expect(body['data'].count).to be <= User.count
      end
    end
  end

  context 'as user' do
    describe '#index' do
      it 'should show not show any user' do
        api_authorize_user user
        get :index

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
