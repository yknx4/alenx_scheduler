require 'rails_helper'

RSpec.describe Appointment, type: :model do
  include_context 'default_tenant'

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

    it 'should be invalid when time overlaps to an existing provider appointment' do
      appointment = create(:appointment)
      invalid_appointment = build(:appointment, provider: appointment.provider, start_time: appointment.start_time + 5.minutes, end_time: appointment.end_time + 1.hour)
      expect(invalid_appointment.valid?).to be_falsey
      expect(invalid_appointment.errors[:provider].present?).to be_truthy
    end

    it 'should be invalid when time overlaps to an existing user appointment' do
      appointment = create(:appointment)
      invalid_appointment = build(:appointment, user: appointment.user, start_time: appointment.start_time + 5.minutes, end_time: appointment.end_time + 1.hour)
      expect(invalid_appointment.valid?).to be_falsey
      expect(invalid_appointment.errors[:user].present?).to be_truthy
    end
  end
end
