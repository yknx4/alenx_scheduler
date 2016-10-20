module Admin
  module ApplicationHelper
    include ::ApplicationHelper
    def indexable_resources
      available_resources.select do |resource|
        policy_for_resource(resource).index?
      end
    end

    def available_resources
      Administrate::Namespace.new(namespace).resources
    end
  end
end
