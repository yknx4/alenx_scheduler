require 'rails_helper'
RSpec.describe Api::V1::UsersController, type: :controller do
  include_context 'default_tenant'
  include ApiControllersHelper
  include UsersControllerHelper
  let(:admin) { create :admin }
  let(:user) { create :user }

  describe '#show' do
    it 'should show current user' do
      selected_user = api_authorize_user admin, user
      get :show, params: { id: selected_user.id }

      expect(response).to have_http_status(:ok)
      expect(response_object).to have_key 'data'
      expect(response_object['data']).to be_a Hash
    end

    it 'should show another user' do
      selected_user = api_authorize_user admin, user
      get :show, params: { id: selected_user.id }

      expect(response).to have_http_status(:ok)
      expect(response_object).to have_key 'data'
      expect(response_object['data']).to be_a Hash
    end
  end

  describe '#update' do
    it 'should be able to update itself' do
      selected_user = api_authorize_user admin, user
      patch :update, params: user_update_params(selected_user.id)

      expect(response).to have_http_status(:ok)
      expect(selected_user.reload.username).to eq user_update_params[:user][:username]
    end
  end

  describe '#delete' do
    it 'should be able to delete itself' do
      selected_user = api_authorize_user admin, user
      delete :destroy, params: { id: selected_user.id }

      expect(response).to have_http_status(:no_content)
      expect(User.where(id: selected_user.id)).to_not exist
    end
  end

  context 'as admin' do
    before do
      api_authorize_user admin
    end

    describe '#index' do
      before do
        50.times { create :user }
      end

      it 'should show all users' do
        get :index

        expect(response).to have_http_status(:ok)
        expect(response_object).to have_key 'data'
        expect(response_object['data'].count).to be_positive
        expect(response_object['data'].count).to be 10
      end

      it 'should show second page' do
        get :index, params: { page: { number: 2 } }

        expect(response).to have_http_status(:ok)
        expect(response_object).to have_key 'data'
        expect(response_object['data'].count).to be_positive
        expect(response_object['data'].count).to be 10

        expected_link = "http://#{tenant.subdomain}.example.com/api/v1/users?page%5Bnumber%5D=2&page%5Bsize%5D=10"
        expect(response_object['links']['self']).to eq expected_link
      end

      it 'should show 15 elements' do
        get :index, params: { page: { size: 15 } }

        expect(response).to have_http_status(:ok)
        expect(response_object).to have_key 'data'
        expect(response_object['data'].count).to be_positive
        expect(response_object['data'].count).to be 15
      end
    end

    describe '#update' do
      it 'should be able to update another user' do
        patch :update, params: user_update_params(user.id)

        expect(response).to have_http_status(:ok)
        expect(user.reload.username).to eq user_update_params[:user][:username]
      end

      it 'should be able to update another user role' do
        patch :update, params: update_role_params(user.id)
        expect(response).to have_http_status(:ok)
        expect(user.reload.role).to eq 'admin'
      end
    end

    describe '#delete' do
      it 'should be able to delete another user' do
        delete :destroy, params: { id: user.id }

        expect(response).to have_http_status(:no_content)
        expect(User.where(id: user.id)).to_not exist
      end
    end

    describe '#create' do
      it 'should be able to create another user' do
        params = user_create_params
        post :create, params: params
        expect(response).to have_http_status(:created)
        expect(response_object).to have_key 'data'
      end
    end
  end

  context 'as user' do
    before do
      api_authorize_user user
    end

    describe '#index' do
      it 'should be forbidden' do
        get :index
        expect_forbidden
      end
    end

    describe '#create' do
      it 'should be forbidden' do
        post :create
        expect_forbidden
      end
    end

    describe '#update' do
      it 'should not be able to update another user' do
        patch :update, params: user_update_params(admin.id)
        expect_forbidden
      end

      it 'should not be able to update the user role' do
        patch :update, params: update_role_params(user.id)
        expect(response).to have_http_status(:ok)
        expect(user.reload.role).to eq 'user'
      end
    end

    describe '#delete' do
      it 'should not be able to delete another user' do
        delete :destroy, params: { id: admin.id }
        expect_forbidden
      end
    end
  end
end
