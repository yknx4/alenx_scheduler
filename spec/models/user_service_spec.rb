require 'rails_helper'

RSpec.describe UserService, type: :model do
  describe '#valid' do
    let(:user_service) { create(:user_service) }

    it 'should be invalid if user and service are duplicated' do
      us = UserService.new user: user_service.user, service: user_service.service
      expect(us.valid?).to be_falsey
    end

    it 'should be invalid if user is blank' do
      us = build(:user_service, user: nil)
      expect(us.valid?).to be_falsey
    end

    it 'should be invalid if service is blank' do
      us = build(:user_service, service: nil)
      expect(us.valid?).to be_falsey
    end
  end
end
