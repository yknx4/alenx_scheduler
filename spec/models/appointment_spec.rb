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
  end
end
