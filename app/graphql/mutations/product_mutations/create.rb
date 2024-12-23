# frozen_string_literal: true

module Mutations
  module ProductMutations
    class Create < BaseMutation
      include ::Authenticatable

      argument :documentation_status, String
      argument :mileage, Int
      argument :model, String
      argument :vehicle_condition, String
      argument :vehicle_name, String
      argument :vehicle_type, String
      argument :year, Int

      field :message, String, null: true

      def resolve(vehicle_name:, vehicle_type:, year:, vehicle_condition:, model:, mileage:, documentation_status:)
        authenticate_user!

        ProductServices::CreateService.instance.create(
          vehicle_name: vehicle_name,
          vehicle_type: vehicle_type,
          year: year,
          vehicle_condition: vehicle_condition,
          model: model,
          mileage: mileage,
          documentation_status: documentation_status
        )
      rescue Exceptions::UnauthorizedError => e
        raise GraphQL::ExecutionError, e.message
      rescue StandardError
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
