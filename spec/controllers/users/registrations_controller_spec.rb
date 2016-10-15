require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe '#create' do
    context 'with subdomain' do
      before do
        request.host = 'sub.example.com'
      end

      it 'should create and admin' do
        
      end
    end

    context 'without subdomain' do
      before do
        request.host = 'www.example.com'
      end

      it 'should create and user' do

      end
    end
  end
end
