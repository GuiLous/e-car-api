# frozen_string_literal: true

module Mutations
  module AssistantServiceMutations
    class Update < BaseMutation
      include ::Authenticatable

      field :message, String, null: false

      argument :assistant_service_attributes, Types::Inputs::AssistantServiceInputType, required: true
      argument :assistant_service_id, ID, required: true

      def resolve(assistant_service_id:, assistant_service_attributes:)
        authenticate_user!

        AssistantServiceServices::UpdateService.instance.update(
          assistant_service_id: assistant_service_id,
          attributes: assistant_service_attributes.to_h
        )
        { message: "SUCCESS" }
      rescue StandardError
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
