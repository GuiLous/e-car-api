# frozen_string_literal: true

class StripeAdapter
  include Singleton

  def process(payload:, sig_header:)
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV.fetch("STRIPE_WEBHOOK_SECRET", nil)
      )
    rescue JSON::ParserError
      Rails.logger.error("Stripe webhook: Invalid payload")
      return
    end

    handle_webhook_event(event)
  end

  def create_checkout_session(price_id:)
    Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: [ {
        price: price_id,
        quantity: 1
      } ],
      mode: "payment",
      success_url: "#{ENV.fetch('FRONTEND_URL', nil)}/checkout/success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "#{ENV.fetch('FRONTEND_URL', nil)}/checkout/cancel"
    )
  end

  private

  def handle_webhook_event(event)
    session_id = event["data"]["object"]["id"]
    purchase = Purchase.find_by(session_id: session_id)

    case event["type"]
    when "checkout.session.completed"
      add_coins_to_user_wallet(session_id, purchase)
      purchase.update!(status: :paid)
    when "checkout.session.expired"
      purchase.update!(status: :cancelled)
    end
  end

  def add_coins_to_user_wallet(session_id, purchase)
    line_items = Stripe::Checkout::Session.list_line_items(session_id)

    product_names = line_items.data.map(&:description)

    total_coins = product_names.sum(&:to_f)

    purchase.user.wallet.add_coins(total_coins * 100)
  end
end
