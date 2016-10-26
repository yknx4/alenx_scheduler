require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe '#valid' do
    it 'should be invalid without a schedule' do
      o = build(:organization, schedule: nil)
      expect(o).to be_invalid
      expect(o.errors).to have_key :schedule
    end

    it 'should be invalid if an organization already exists' do
      create(:organization)
      o = build(:organization)
      expect(o).to be_invalid
      expect(o.errors).to have_key :base
    end
  end
  describe '#new' do
    it 'should create a schedule if not present' do
      o = Organization.create! name: 'test'
      expect(o.schedule).to be_present
    end
  end
end
