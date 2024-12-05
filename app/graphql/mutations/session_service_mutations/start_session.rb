# frozen_string_literal: true

module Mutations
  module SessionServiceMutations
    class StartSession < BaseMutation
      include ::Authenticatable

      argument :hired_service_id, ID, required: true

      field :session, Types::SessionType, null: false

      def resolve(hired_service_id:)
        authenticate_user!
        session_service = SessionServices::SessionStartService.instance.start(hired_service_id: hired_service_id, current_user: context[:current_user])
        { session: session_service }
      rescue StandardError => e
        Rails.logger.error e.message
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
