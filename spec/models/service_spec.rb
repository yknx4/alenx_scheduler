require 'rails_helper'

RSpec.describe Service, type: :model do
  let(:service) { create(:service) }
  describe '#valid' do
    it 'should be invalid when tag already exists' do
      p = Service.new(tag: service.tag)
      expect(p.valid?).to be_falsey
    end
  end
end
