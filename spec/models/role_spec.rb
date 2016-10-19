require 'rails_helper'

RSpec.describe Role, type: :model do
  include_context 'default_tenant'

  describe '#roles' do
    let!(:user) {create(:user)}
    let!(:admin) {create(:admin)}
    let!(:provider) {create(:provider)}

    it 'should have 3 users' do
      expect(User.count).to eq 3
    end

    it 'should only list admins for Admin' do
      expect(User.admins.count).to eq 1
    end

    it 'should only list admins for User' do
      expect(User.users.count).to eq 1
    end

    it 'should only list admins for Provider' do
      expect(User.providers.count).to eq 1
    end

  end
end
