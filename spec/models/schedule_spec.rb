require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe '#new' do
    it 'should have default hours' do
      schedule = Schedule.new
      expect(schedule.hours).to be_present
    end
  end
end
