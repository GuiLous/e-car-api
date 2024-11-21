# frozen_string_literal: true

module Mutations
  module AssistantServiceMutations
    class Add < BaseMutation
      include ::Authenticatable

      field :message, String, null: false

      argument :modality, String, required: true
      argument :price, Integer, required: true
      argument :service_category_id, ID, required: true
      argument :service_id, ID, required: true

      def resolve(modality:, price:, service_id:, service_category_id:)
        authenticate_user!

        AssistantServiceServices::CreateService.instance.create(
          modality: modality,
          price: price,
          service_id: service_id,
          service_category_id: service_category_id,
          context: context
        )
        { message: "SUCCESS" }
      rescue Exceptions::AssistantServiceAlreadyExistsError => e
        raise GraphQL::ExecutionError, e.message
      rescue StandardError
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
