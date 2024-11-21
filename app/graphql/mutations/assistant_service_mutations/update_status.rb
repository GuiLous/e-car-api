# frozen_string_literal: true

module Mutations
  module AssistantServiceMutations
    class UpdateStatus < BaseMutation
      include ::Authenticatable

      field :message, String, null: false

      argument :assistant_service_id, ID, required: true
      argument :status, String, required: true

      def resolve(assistant_service_id:, status:)
        authenticate_user!

        AssistantServiceServices::UpdateStatusService.instance.update_status(
          assistant_service_id: assistant_service_id,
          status: status
        )
        { message: "SUCCESS" }
      rescue StandardError
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
