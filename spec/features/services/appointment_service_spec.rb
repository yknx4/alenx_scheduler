require 'rails_helper'

RSpec.describe AppointmentService, type: :feature do
  describe '#make_appointment' do
    let(:user) { create(:user) }
    let(:provider) { create(:provider) }

    it 'should create an appointment with proper options' do
      service = AppointmentService.new user: user, provider: provider
    end

    it 'should not create an appointment with missing data' do
    end

  end
end
