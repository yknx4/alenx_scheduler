require 'rails_helper'

RSpec.describe BaseAppointmentService, type: :feature do
  include_context 'default_tenant'

  let(:service) { BaseAppointmentService.new }

  describe '#make_appointment' do
    it 'should raise NotImplementedError' do
      expect { service.make_appointment(nil, nil) }.to raise_error NotImplementedError
    end
  end

  describe '#get_appointment' do
    it 'should raise NotImplementedError' do
      expect { service.get_appointments }.to raise_error NotImplementedError
    end
  end

  describe '#available_slots' do
    it 'should raise NotImplementedError' do
      expect { service.available_slots(nil, nil) }.to raise_error NotImplementedError
    end
  end

  describe '#cancel_appointment' do
    it 'should raise NotImplementedError' do
      expect { service.cancel_appointment(nil) }.to raise_error NotImplementedError
    end
  end
end
