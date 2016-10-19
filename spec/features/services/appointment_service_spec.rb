require 'rails_helper'

RSpec.describe AppointmentService, type: :feature do
  describe '#make_appointment' do
    let(:user) { create(:user) }
    let(:provider) { create(:provider) }

    it 'should create an appointment with proper options' do
      a_service = AppointmentService.new user: user, provider: provider
      appointment = a_service.make_appointment Time.now, 15.minutes.from_now
      expect(appointment).to be_a Appointment
      expect(Appointment.count).to eq 1
    end

    it 'should not create an appointment with missing user' do
      a_service = AppointmentService.new provider: provider
      expect { a_service.make_appointment Time.now, 15.minutes.from_now }.to raise_error TypeError
    end

    it 'should not create an appointment with missing provider' do
      a_service = AppointmentService.new user: user
      expect { a_service.make_appointment Time.now, 15.minutes.from_now }.to raise_error TypeError
    end

    it 'should raise errors if new appointment is not valid' do
      a_service = AppointmentService.new user: user, provider: provider
      expect { a_service.make_appointment 15.minutes.from_now, Time.now }.to raise_error ActiveRecord::RecordInvalid
    end

  end
end
