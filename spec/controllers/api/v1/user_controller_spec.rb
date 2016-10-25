require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  include_context 'default_tenant'
  describe '#index' do
    it 'should show all users' do
      rand(10).times { create :user }
      get :index
    end
  end
end
