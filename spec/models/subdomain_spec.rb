require 'rails_helper'

RSpec.describe Subdomain, type: :model do
  describe '#matches?' do
    it 'should match any subdomain' do
      subdomain = 'test'
      subdomain.class.send :alias_method, :subdomain, :to_s
      expect(Subdomain.matches?(subdomain)).to be_truthy
    end

    it 'should not match www' do
      subdomain = 'www'
      subdomain.class.send :alias_method, :subdomain, :to_s
      expect(Subdomain.matches?(subdomain)).to be_falsey
    end

    it 'should not match without subdomain' do
      subdomain = ''
      subdomain.class.send :alias_method, :subdomain, :to_s
      expect(Subdomain.matches?(subdomain)).to be_falsey
    end
  end
end
