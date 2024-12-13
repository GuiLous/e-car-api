# frozen_string_literal: true

class StripeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def webhook
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]

    PaymentGatewayServices::ProcessWebhookService.instance.process(payload: payload, sig_header: sig_header)

    head :ok
  end
end
