# frozen_string_literal: true

module Mutations
  module AssistantServiceMutations
    class Add < BaseMutation
      include ::Authenticatable

      field :message, String, null: false

      argument :description, String, required: true
      argument :modality, String, required: true
      argument :price, Integer, required: true
      argument :service_category_id, ID, required: true
      argument :title, String, required: true

      def resolve(title:, modality:, price:, service_category_id:, description: nil)
        authenticate_user!

        AssistantServiceServices::CreateService.instance.create(
          title: title,
          modality: modality,
          price: price,
          service_category_id: service_category_id,
          description: description,
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
