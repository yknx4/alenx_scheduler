require 'rails_helper'

RSpec.describe 'routes', type: :request do
  describe 'with blank subdomain' do
    it 'should redirect to www' do
      expect(get('http://example.com/')).to redirect_to 'http://www.example.com/'
    end
  end
end
