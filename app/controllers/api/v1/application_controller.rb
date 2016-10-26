module Api
  module V1
    class ApplicationController < ::ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
    end
  end
end
