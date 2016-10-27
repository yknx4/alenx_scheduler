require 'rails_helper'
RSpec.describe Api::V1::UsersController, type: :controller do
  include_context 'default_tenant'
  include ApiControllersHelper
  include UsersControllerHelper
  let(:admin) { create :admin }
  let(:user) { create :user }

  describe '#show' do
    it 'should show current user' do
      api_authorize_user admin
      get :show, params: { id: admin.id }

      expect(response).to have_http_status(:ok)
      expect(response_object).to have_key 'data'
      expect(response_object['data']).to be_a Hash
    end

    it 'should show another user' do
      api_authorize_user admin
      get :show, params: { id: user.id }

      expect(response).to have_http_status(:ok)
      expect(response_object).to have_key 'data'
      expect(response_object['data']).to be_a Hash
    end
  end

  describe '#update' do
    it 'should be able to update itself' do
      selected_user = [user, admin].sample
      api_authorize_user selected_user
      patch :update, params: user_update_params(selected_user.id)

      expect(response).to have_http_status(:ok)
      expect(selected_user.reload.username).to eq user_update_params[:user][:username]
    end
  end

  context 'as admin' do
    describe '#index' do
      it 'should show all users' do
        rand(20).times { create :user }

        api_authorize_user admin
        get :index

        expect(response).to have_http_status(:ok)
        expect(response_object).to have_key 'data'
        expect(response_object['data'].count).to be_positive
        expect(response_object['data'].count).to be <= User.count
      end
    end

    describe '#update' do
      it 'should be able to update another user' do
        api_authorize_user admin
        patch :update, params: user_update_params(user.id)

        expect(response).to have_http_status(:ok)
        expect(user.reload.username).to eq user_update_params[:user][:username]
      end

      it 'should be able to update another user role' do
        api_authorize_user admin
        patch :update, params: update_role_params(user.id)
        expect(response).to have_http_status(:ok)
        expect(user.reload.role).to eq 'admin'
      end
    end

    describe '#create' do
      it 'should be able to create another user' do
        api_authorize_user user
        post :create

        expect_forbidden
      end
    end
  end

  context 'as user' do
    describe '#index' do
      it 'should be forbidden' do
        api_authorize_user user
        get :index

        expect_forbidden
      end
    end

    describe '#create' do
      it 'should be forbidden' do
        api_authorize_user user
        post :create

        expect_forbidden
      end
    end

    describe '#update' do
      it 'should not be able to update another user' do
        api_authorize_user user
        patch :update, params: user_update_params(admin.id)

        expect_forbidden
      end

      it 'should not be able to update the user role' do
        api_authorize_user user
        patch :update, params: update_role_params(user.id)
        expect(response).to have_http_status(:ok)
        expect(user.reload.role).to eq 'user'
      end
    end
  end
end
