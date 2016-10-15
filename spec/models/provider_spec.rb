require 'rails_helper'

RSpec.describe Provider, type: :model do
  describe '#roles' do
    it 'should have provider role by default' do
      user = create(:provider)
      expect(user.has_role?(:provider)).to be_truthy
    end
  end
end
