# frozen_string_literal: true

module Types
  module Concerns
    module AssistantServiceFields
      extend ActiveSupport::Concern

      included do
        field :assistant_services, [ Types::AssistantServiceType ], null: false do
          argument :filters, Types::AssistantServiceFiltersType, required: false
        end

        field :assistant_service, Types::AssistantServiceType, null: true do
          argument :id, GraphQL::Types::ID, required: true
        end
      end

      def assistant_services(filters: nil)
        query = AssistantService.where(visible: true).includes(:assistant, :service)
      end

      def assistant_service(id:)
        AssistantService.joins(:assistant, :service_category).find_by(id: id)
end
