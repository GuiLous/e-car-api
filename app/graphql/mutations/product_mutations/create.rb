# frozen_string_literal: true

module Mutations
  module ProductMutations
    class Create < BaseMutation
      include ::Authenticatable

      argument :documentation_status, String, required: true
      argument :mileage, Int, required: true
      argument :model, String, required: true
      argument :price, Float, required: true
      argument :vehicle_condition, String, required: true
      argument :vehicle_name, String, required: true
      argument :vehicle_type, String, required: true
      argument :year, Int, required: true

      field :message, String, null: true

      def resolve(vehicle_name:, vehicle_type:, year:, vehicle_condition:, model:, mileage:, documentation_status:, price:)
        authenticate_user!

        ProductServices::CreateService.instance.create(
          vehicle_name: vehicle_name,
          vehicle_type: vehicle_type,
          year: year,
          vehicle_condition: vehicle_condition,
          model: model,
          mileage: mileage,
          documentation_status: documentation_status,
          price: price,
          user: context[:current_user]
        )
      rescue Exceptions::UnauthorizedError => e
        raise GraphQL::ExecutionError, e.message
      rescue StandardError
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
