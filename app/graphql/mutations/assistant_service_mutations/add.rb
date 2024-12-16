# frozen_string_literal: true

module Mutations
  module AssistantServiceMutations
    class Add < BaseMutation
      include ::Authenticatable

      field :message, String, null: false

      argument :deadline, String
      argument :description, String, required: true
      argument :modality, String, required: true
      argument :price, Integer, required: true
      argument :service_category_id, ID, required: true
      argument :title, String, required: true

      def resolve(title:, modality:, price:, service_category_id:, deadline: nil, description: nil)
        authenticate_user!
        puts "DEADLINE: #{deadline}"
        AssistantServiceServices::CreateService.instance.create(
          title: title,
          modality: modality,
          price: price,
          service_category_id: service_category_id,
          deadline: deadline,
          description: description,
          context: context
        )
        { message: "SUCCESS" }
      rescue Exceptions::AssistantServiceAlreadyExistsError => e
        raise GraphQL::ExecutionError, e.message
      rescue StandardError => e
        puts e.message
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
