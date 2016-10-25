module Api
  module V1
    class UsersController < ResourceController
      def index
        options = {}
        serialization = ActiveModelSerializers::SerializableResource.new(User.all, options)
        render json: serialization.as_json
      end
    end
  end
end
