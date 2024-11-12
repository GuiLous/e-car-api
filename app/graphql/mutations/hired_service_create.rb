# frozen_string_literal: true

module Mutations
  class HiredServiceCreate < BaseMutation
    field :hired_service, Types::HiredServiceType, null: false

    argument :assistant_service_id, ID, required: true
    argument :schedule_date, GraphQL::Types::ISO8601Date, required: true

    def resolve(assistant_service_id:, schedule_date:)
      hired_service = HireAssistantService::CreateService.instance.create(assistant_service_id: assistant_service_id, schedule_date: schedule_date)
      { hired_service: hired_service }
    rescue Exceptions::SameUserError => e
      raise GraphQL::ExecutionError, e.message
    rescue StandardError => e
      Rails.logger.error e.message
      raise GraphQL::ExecutionError, "SYSTEM_ERROR"
    end
  end
end
