require 'rails_helper'

RSpec.describe Appointment, type: :model do
  include_context 'default_tenant'

  describe '#valid' do
    it 'should be invalid without a provider' do
      a = build(:appointment, provider: nil)
      expect(a).to be_invalid
    end

    it 'should be invalid without an user' do
      a = build(:appointment, user: nil)
      expect(a).to be_invalid
    end

    it 'should be invalid when the start time is greater than end time' do
      a = build(:appointment, start_time: 15.minutes.from_now, end_time: Time.current)
      expect(a).to be_invalid
    end

    it 'should be invalid when time overlaps to an existing provider appointment' do
      appointment = create(:appointment)
      invalid_appointment = build(:appointment,
                                  provider: appointment.provider,
                                  start_time: appointment.start_time + 5.minutes,
                                  end_time: appointment.end_time + 1.hour)
      expect(invalid_appointment).to be_invalid
      expect(invalid_appointment.errors[:provider]).to be_present
    end

    it 'should be invalid when time overlaps to an existing user appointment' do
      appointment = create(:appointment)
      invalid_appointment = build(:appointment,
                                  user: appointment.user,
                                  start_time: appointment.start_time + 5.minutes,
                                  end_time: appointment.end_time + 1.hour)
      expect(invalid_appointment).to be_invalid
      expect(invalid_appointment.errors[:user]).to be_present
    end

    it 'should be valid when start_time and end_time are on different days' do
      a = build(:appointment, start_time: Time.current, end_time: 1.day.from_now)
      expect(a).to be_valid
      expect(a.errors[:start_time]).to be_empty
    end
  end
end
