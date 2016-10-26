require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  include_context 'default_tenant'
  include ApiControllersHelper
  let(:admin) { create :admin }
  let(:user) { create :user }

  describe '#index' do
    context 'as admin' do
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

    context 'as user' do
      it 'should show all users' do
        rand(20).times { create :user }

        api_authorize_user user
        expect do
          get :index
        end.to raise_error Pundit::NotAuthorizedError
      end
    end
  end
end
