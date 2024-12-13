# frozen_string_literal: true

module Mutations
  module PaymentGatewayMutations
    class CreateCheckoutSession < BaseMutation
      include ::Authenticatable

      argument :price, Float, required: true
      argument :price_id, String, required: true

      field :session_id, String, null: false
      field :session_url, String, null: false

      def resolve(price:, price_id:)
        authenticate_user!

        PaymentGatewayServices::CreateCheckoutSessionService.instance.create_checkout_session(
          price: price,
          price_id: price_id,
          current_user: context[:current_user]
        )
      rescue StandardError
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
