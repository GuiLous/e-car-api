# frozen_string_literal: true

module Mutations
  module HiredServiceMutations
    class HireAssistant < BaseMutation
      include ::Authenticatable

      field :hired_service, Types::HiredServiceType, null: false

      argument :assistant_service_id, ID, required: true
      argument :schedule_date, GraphQL::Types::ISO8601Date, required: true

      def resolve(assistant_service_id:, schedule_date:)
        authenticate_user!

        hired_service = HiredServices::HireAssistantService.instance.hire(assistant_service_id: assistant_service_id, schedule_date: schedule_date, context: context)
        { hired_service: hired_service }
      rescue Exceptions::InsufficientCoinsError, Exceptions::SameUserError => e
        raise GraphQL::ExecutionError, e.message
      rescue StandardError => e
        Rails.logger.error e.message
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
