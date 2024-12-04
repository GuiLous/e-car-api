# frozen_string_literal: true

module Mutations
  module SessionServiceMutations
    class StartSession < BaseMutation
      include ::Authenticatable

      argument :hired_service_id, ID, required: true

      field :session, Types::SessionType, null: false

      def resolve(hired_service_id:)
        authenticate_user!
        hired_service = HiredService.find(hired_service_id)
        raise Exceptions::HiredServiceItsNotLive unless hired_service.assistant_service.live?

        session_service = SessionServices::SessionStartService.instance.start(hired_service: hired_service, current_user: context[:current_user])
        { session: session_service }
      rescue StandardError => e
        Rails.logger.error e.message
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
