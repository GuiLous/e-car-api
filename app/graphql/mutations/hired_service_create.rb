# frozen_string_literal: true

module Mutations
  class HiredServiceCreate < BaseMutation
    field :hired_service, Types::HiredServiceType, null: false

    argument :assistant_service_id, ID, required: true
    argument :schedule_date, GraphQL::Types::ISO8601Date, required: true

    def resolve(assistant_service_id:, schedule_date:)
      current_user = User.first

      assistant_service = ::AssistantService.find(assistant_service_id)

      raise GraphQL::ExecutionError, "SAME_ACCOUNT_ERROR" if assistant_service.assistant.user_id == current_user.id

      hired_service = ::HiredService.new(assistant_service_id: assistant_service_id, schedule_date: schedule_date, user: current_user)

      raise GraphQL::ExecutionError.new "ERROR_ON_CREATE_HIRED_SERVICE", extensions: hired_service.errors.to_hash unless hired_service.save

      { hired_service: hired_service }
    end
  end
end
