# frozen_string_literal: true

module Types
  module Concerns
    module SessionServiceFields
      extend ActiveSupport::Concern

      included do
        field :sessions_service, [SessionServiceType], null: false

        field :session_by_hired_service, SessionServiceType, null: false do
          argument :hired_service_id, Integer, required: false
        end

        field :session_service, SessionServiceType, null: false do
          argument :session_service_id, Integer, required: false
        end
      end

      def sessions_service
        authenticate_user!
        SessionService.all
      end

      def session_service(session_service_id:)
        authenticate_user!
        current_user = context[:current_user]
        session_service = SessionService.find(session_service_id)

        if current_user.assistant?
          return session_service if session_service.hired_service.user.id == current_user.id
          raise "NOT_IN_SESSION" if session_service.hired_service.assistant_service.assistant.user.id != current_user.id
        end

        raise "NOT_IN_SESSION" if current_user.customer? && session_service.hired_service.user.id != current_user.id
        session_service
      end

      def session_by_hired_service(hired_service_id:)
        authenticate_user!
        SessionService.where("? = ANY (hired_service_id)", hired_service_id).first
      end
    end
  end
end
