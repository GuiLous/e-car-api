# frozen_string_literal: true

module PaymentGatewayServices
  class CreateCheckoutSessionService
    include Singleton

    def create_checkout_session(price:, price_id:, current_user:)
      session = StripeAdapter.instance.create_checkout_session(price_id: price_id)

      Purchase.create!(
        price: price,
        price_id: price_id,
        session_id: session.id,
        user: current_user
      )

      { session_url: session.url, session_id: session.id }
    end
  end
end
