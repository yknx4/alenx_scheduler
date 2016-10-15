require 'rails_helper'

RSpec.describe Role, type: :model do
  describe '#roles' do
    let!(:user) {create(:user)}
    let!(:admin) {create(:admin)}
    let!(:provider) {create(:provider)}

    it 'should have 3 users' do
      expect(User.unscoped.count).to eq 3
    end

    it 'should only list admins for Admin' do
      expect(Admin.count).to eq 1
    end

    it 'should only list admins for User' do
      expect(User.count).to eq 1
    end

    it 'should only list admins for Provider' do
      expect(Provider.count).to eq 1
    end

  end
end
