module Api
  module V1
    class ResourceController < ApplicationController
      include Pundit
      extend ::Memoist

      before_action :authenticate_user!
      before_action :run_authorization
      after_action :verify_authorized

      def index
        render json: resource_collection.page(page_number).per(page_size)
      end

      def self.run_on_model(*actions)
        self.model_actions += actions
      end

      protected

      cattr_accessor :model_actions
      BASE_MODEL_ACTIONS = %w(create index new).freeze

      def complete_model_actions
        complete_model_actions = BASE_MODEL_ACTIONS
        complete_model_actions += model_actions if model_actions.is_a? Array
        complete_model_actions.map(&:to_s).uniq
      end

      def requested_resource
        resource_class.find resource_id
      end
      memoize :requested_resource

      def resource_collection
        resource_class.all
      end

      def page
        params.permit(page: [:number, :size])
      end

      def page_number
        page.fetch(:page_number, 1)
      end

      def page_size
        page.fetch(:page_size, 10)
      end

      def resource_id
        params.permit(:id).fetch(:id)
      end

      def resource_name
        self.class.name.gsub('Controller', '').singularize
      end

      private

      def run_authorization
        if complete_model_actions.include? action_name
          authorize resource_class
        else
          authorize requested_resource
        end
      end
    end
  end
end
