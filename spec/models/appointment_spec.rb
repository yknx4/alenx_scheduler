require 'rails_helper'

RSpec.describe Appointment, type: :model do
  describe '#valid' do
    it 'should be invalid without a provider' do
      a = build(:appointment, provider: nil)
      expect(a.valid?).to be_falsey
    end

    it 'should be invalid without an user' do
      a = build(:appointment, user: nil)
      expect(a.valid?).to be_falsey
    end

    it 'should be invalid when the start time is greater than end time' do
      a = build(:appointment, start_time: 15.minutes.from_now, end_time: Time.now)
      expect(a.valid?).to be_falsey
    end
  end
end
