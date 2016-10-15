require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#without_tenant?' do
    it 'should return true with no subdomain' do
      @request.host = 'example.com'
      expect(without_tenant?).to be_truthy
    end

    it 'should return true with subdomain www' do
      @request.host = 'www.example.com'
      expect(without_tenant?).to be_truthy
    end

    it 'should return false with any' do
      @request.host = 'any.example.com'
      expect(without_tenant?).to be_falsey
    end
  end
end
