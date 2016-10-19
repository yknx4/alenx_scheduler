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

  end
end
