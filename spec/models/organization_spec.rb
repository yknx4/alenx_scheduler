require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe '#valid' do
    it 'should be invalid without a schedule' do
      o = build(:organization, schedule: nil)
      expect(o.valid?).to be_falsey
      expect(o.errors[:schedule].empty?).to be_falsey
    end
  end
  describe '#new' do
    it 'should create a schedule if not present' do
      o = Organization.create name: 'test'
      expect(o.schedule.present?).to be_truthy
    end
  end
end
