# frozen_string_literal: true

module Types
  module Concerns
    module SessionServiceFields
      extend ActiveSupport::Concern

      included do
        field :sessions, [ SessionType ], null: false

        field :session_by_hired_service, SessionType, null: false do
          argument :hired_service_id, Integer, required: false
        end
      end

      def sessions
        authenticate_user!
        SessionService.all
      end

      def session_by_hired_service(hired_service_id:)
        authenticate_user!
        SessionService.where("? = ANY (hired_service_id)", hired_service_id).first
      end
    end
  end
end
