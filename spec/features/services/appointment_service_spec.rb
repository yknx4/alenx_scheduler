require 'rails_helper'

RSpec.describe AppointmentService, type: :feature do
  let(:user) { create(:user) }
  let(:provider) { create(:provider) }

  describe '#make_appointment' do
    let(:a_service) { AppointmentService.new user: user, provider: provider }

    it 'should create an appointment with proper options' do
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
      expect { a_service.make_appointment 15.minutes.from_now, Time.now }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe '#get_appointments' do
    let(:provider2) { create(:provider) }
    let(:appointments) do
      [
          create(:appointment, user: user, provider: provider),
          create(:appointment, user: user, provider: provider),
          create(:appointment, user: user),
          create(:appointment, user: user)
      ]
    end

    before do
      create(:appointment, provider: provider)
      create(:appointment)
    end

    context 'with only an user' do
      let(:appointment_service) { AppointmentService.new user: user }

      it 'should get all users appointments' do
        expect(appointment_service.get_appointments).to match_array Appointment.where(user_id: user.id).to_a
      end
    end

    context 'with only a provider' do
      let(:appointment_service) { AppointmentService.new provider: provider }

      it 'should get all provider appointments' do
        expect(appointment_service.get_appointments).to match_array Appointment.where(provider_id: provider.id).to_a
      end
    end

    context 'with both provider and user' do
      let(:appointment_service) { AppointmentService.new user: user, provider: provider }

      it 'should get all providers user appointments' do
        expect(appointment_service.get_appointments).to match_array Appointment.where(provider_id: provider.id, user_id: user.id).to_a
      end
    end
  end
end
