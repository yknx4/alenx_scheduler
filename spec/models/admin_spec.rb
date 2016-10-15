require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '#roles' do
    it 'should have admin role by default' do
      user = create(:admin)
      expect(user.has_role?(:admin)).to be_truthy
    end
  end
end
