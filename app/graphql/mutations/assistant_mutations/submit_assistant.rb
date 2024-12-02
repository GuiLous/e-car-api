# frozen_string_literal: true

module Mutations
  module AssistantMutations
    class SubmitAssistant < BaseMutation
      include ::Authenticatable

      field :message, String, null: false

      argument :description, String, required: true
      argument :modality, String, required: true
      argument :price, Integer, required: true
      argument :service_category_id, ID, required: true
      argument :title, String, required: true

      def resolve(description:, modality:, price:, service_category_id:, title:)
        authenticate_user!

        AssistantSubmissionServices::CreateService.instance.create(
          user: context[:current_user],
          description: description,
          modality: modality,
          price: price,
          service_category_id: service_category_id,
          title: title
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
