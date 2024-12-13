# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StripeController do
  let(:payload) { '{"event": "test_event"}' }
  let(:sig_header) { 'xpto' }

  describe 'POST #webhook' do
    it 'calls the webhook action' do
      expect(PaymentGatewayServices::ProcessWebhookService.instance).to receive(:process)

      request.env['HTTP_STRIPE_SIGNATURE'] = sig_header

      post :webhook, body: payload

      expect(response).to have_http_status(:ok)
    end
  end
end
