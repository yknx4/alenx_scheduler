require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#roles' do
    it 'should have user role by default' do
      user = create(:user)
      expect(user.has_role?(:user)).to be_truthy
    end
  end
end
