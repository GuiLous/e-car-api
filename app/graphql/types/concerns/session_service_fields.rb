# frozen_string_literal: true

module Types
  module Concerns
    module SessionServiceFields
      extend ActiveSupport::Concern

      included do
        field :session_service, SessionServiceType, null: false do
          argument :session_service_id, Integer, required: false
        end
      end

      def session_service(session_service_id:)
        authenticate_user!
        current_user = context[:current_user]
        session_service = SessionService.find(session_service_id)

        raise GraphQL::ExecutionError, "NOT_IN_SESSION" unless authorized_user?(session_service, current_user)

        session_service
      end

      def authorized_user?(session_service, user)
        return true if session_service.hired_service.user.id == user.id
        return true if user.assistant? && session_service.hired_service.assistant_service.assistant.user.id == user.id

        false
      end
    end
  end
end
