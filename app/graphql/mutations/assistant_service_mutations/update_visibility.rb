# frozen_string_literal: true

module Mutations
  module AssistantServiceMutations
    class UpdateVisibility < BaseMutation
      include ::Authenticatable

      field :message, String, null: false

      argument :assistant_service_id, ID, required: true
      argument :visible, String, required: true

      def resolve(assistant_service_id:, visible:)
        authenticate_user!

        AssistantServiceServices::UpdateVisibilityService.instance.update_visibility(
          assistant_service_id: assistant_service_id,
          visible: visible
        )
        { message: "SUCCESS" }
      rescue StandardError
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
