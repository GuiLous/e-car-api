# frozen_string_literal: true

module Mutations
  module HiredServiceMutations
    class FinishHiredService < BaseMutation
      include ::Authenticatable

      field :message, String, null: false

      argument :hired_service_id, ID, required: true

      def resolve(hired_service_id:)
        authenticate_user!

        HiredServices::UpdateToAnalizingService.instance.update_to_analizing(hired_service_id: hired_service_id)
        { message: "SUCCESS" }
      rescue StandardError
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
