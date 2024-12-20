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
        apply_filters(query, filters)
      end

      def assistant_service(id:)
        AssistantService.joins(:assistant, :service_category).find_by(id: id)
      end

      private

      def apply_filters(query, filters)
        return query.all unless filters

        query = filter_by_assistant(query, filters)
        query = filter_by_modality(query, filters)
        query = filter_by_service_category(query, filters)
        query = apply_online_filter(query, filters.status) unless filters.status.nil?

        query.all
      end

      def filter_by_assistant(query, filters)
        return query if filters.assistant_id.blank?

        query.where(assistant_id: filters.assistant_id)
      end

      def filter_by_modality(query, filters)
        return query if filters.modality.blank?

        query.where(modality: filters.modality)
      end

      def filter_by_service_category(query, filters)
        return query if filters.service_category_id.blank?

        query.where(service_category_id: filters.service_category_id)
      end

      def apply_online_filter(query, status)
        return query.joins(assistant: { user: {} }).where(users: { status: %i[online in_live] }) if status == "online"
        return query.joins(assistant: { user: {} }).where(users: { status: [ :offline ] }) if status == "offline"

        query.joins(assistant: { user: {} })
      end
    end
  end
end
