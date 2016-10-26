require 'rails_helper'

RSpec.describe DeviseTokenAuth::SessionsController, type: :controller do
  include_context 'default_tenant'
  include RegistrationsHelper

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe '#create' do
    let(:user) { create :user }
    it 'should get an user token' do
      params = { password: 'password', email: user.email }
      post :create, params: params
      expect(response).to have_http_status :ok
      headers = %w(access-token token-type client expiry uid)
      headers.each { |header| expect(response).to have_header header }
    end
  end
end
