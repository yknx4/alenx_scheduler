require 'rails_helper'

RSpec.describe AppointmentService, type: :feature do
  include AppointmentServiceHelper
  include ScheduleHelper
  include_context 'default_tenant'

  let(:user) { create(:user) }
  let(:provider) { create(:provider) }
  let(:service) { create(:service) }

  describe '#available_slots' do
    let(:provider2) { create(:provider) }

    context 'with full schedule' do
      before do
        setup_full_schedule tenant.organization
        setup_full_schedule provider
        setup_full_schedule provider2
      end

      context 'without provider' do
        it 'should show all day as slot for each provider' do
          slots = get_available_slots user: user
          expect(slots.all? { |_id, lapse| is_full_day_lapse? lapse.first }).to be_truthy
          expect(slots.count).to eq User.providers.count
        end

        it 'should show all day as slot for each provider with the service' do
          provider.services << service
          provider2.services << create(:service)
          slots = get_available_slots user: user, services: [service.id]
          expect(slots[provider2.id]).to_not be_present
          expect(slots[provider.id]).to be_present
          expect(is_full_day_lapse?(slots[provider.id].first)).to be_truthy
          expect(slots.count).to eq 1
        end

        it 'should show nothing if any provider has the service' do
          slots = get_available_slots user: user, services: [service.id]
          expect(slots[provider2.id]).to_not be_present
          expect(slots[provider2.id]).to_not be_present
          expect(slots.count).to eq 0
        end
      end

      context 'with provider' do
        it 'should show all day as slot for provider' do
          slots = get_available_slots user: user, provider: provider
          expect(slots[provider.id]).to be_present
          expect(is_full_day_lapse?(slots[provider.id].first)).to be_truthy
          expect(slots.count).to eq 1
        end

        it 'should show nothing if provider doesnt have the service' do
          provider.services << create(:service)
          provider2.services << service
          slots = get_available_slots provider: provider, services: [service.id]
          expect(slots[provider2.id]).to_not be_present
          expect(slots[provider.id]).to_not be_present
          expect(slots.count).to eq 0
        end

      end
    end
  end

  describe '#make_appointment' do
    let(:a_service) { AppointmentService.new user: user, provider: provider }

    it 'should create an appointment with proper options' do
      appointment = a_service.make_appointment Time.current, 15.minutes.from_now
      expect(appointment).to be_a Appointment
      expect(Appointment.count).to eq 1
    end

    it 'should not create an appointment with missing user' do
      a_service = AppointmentService.new provider: provider
      expect { a_service.make_appointment Time.current, 15.minutes.from_now }.to raise_error TypeError
    end

    it 'should not create an appointment with missing provider' do
      a_service = AppointmentService.new user: user
      expect { a_service.make_appointment Time.current, 15.minutes.from_now }.to raise_error TypeError
    end

    it 'should raise errors if new appointment is not valid' do
      expect { a_service.make_appointment 15.minutes.from_now, Time.current }.to raise_error ActiveRecord::RecordInvalid
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

    it 'should get only appointments within a time frame' do
      appointment_service = AppointmentService.new user: user

      start_time = appointments.first.start_time
      end_time = appointments.first.end_time

      expected_appointments = Appointment.within(start_time, end_time).to_a

      expect(appointment_service.get_appointments(start_time, end_time)).to match_array expected_appointments
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
        expected_appointments = Appointment.where(provider_id: provider.id, user_id: user.id).to_a
        expect(appointment_service.get_appointments).to match_array expected_appointments
      end
    end
  end
end
