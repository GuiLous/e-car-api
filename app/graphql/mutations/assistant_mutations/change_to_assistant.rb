# frozen_string_literal: true

module Mutations
  module AssistantMutations
    class ChangeToAssistant < BaseMutation
      field :message, String, null: false

      argument :description, String, required: true
      argument :modality, String, required: true
      argument :nickname, String, required: true
      argument :price, Integer, required: true
      argument :service_category_id, ID, required: true
      argument :service_id, ID, required: true
      argument :user_id, ID, required: true

      def resolve(user_id:, nickname:, description:, modality:, price:, service_id:, service_category_id:)
        AssistantServices::ChangeToAssistantService.instance.change_to_assistant(
          user_id: user_id,
          nickname: nickname,
          description: description,
          modality: modality,
          price: price,
          service_id: service_id,
          service_category_id: service_category_id
        )
        { message: "SUCCESS" }
      rescue Exceptions::UserIsAlreadyAnAssistantError => e
        raise GraphQL::ExecutionError, e.message
      rescue StandardError
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
