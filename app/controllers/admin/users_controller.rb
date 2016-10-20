module Admin
  class UsersController < Admin::ApplicationController
    include Pundit
    protect_from_forgery

    before_action :run_authorization

    private

    def run_authorization
      case action_name
      when 'create', 'index', 'new'
        authorize User
      else
        authorize requested_resource
      end
    end
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = User.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   User.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
