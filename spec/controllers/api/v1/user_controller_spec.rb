require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  include_context 'default_tenant'
  let(:admin) { create :admin }
  let(:token) { lambda { admin.create_new_auth_token } }

  describe '#index' do
    it 'should show all users' do
      rand(20).times { create :user }
      request.headers.merge! token.call
      get :index
      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body).to have_key 'data'
      expect(body['data'].count).to be_positive
      expect(body['data'].count).to be <= User.count
    end
  end
end
