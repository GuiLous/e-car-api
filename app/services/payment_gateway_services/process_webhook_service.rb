# frozen_string_literal: true

module PaymentGatewayServices
  class ProcessWebhookService
    include Singleton

    def process(payload:, sig_header:)
      StripeAdapter.instance.process(payload: payload, sig_header: sig_header)
    end
  end
end
