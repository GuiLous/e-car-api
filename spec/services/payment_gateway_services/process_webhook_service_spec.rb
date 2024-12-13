# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentGatewayServices::ProcessWebhookService do
  describe '#process' do
    it 'call adapter with correct argument' do
      allow(StripeAdapter.instance).to receive(:process)

      payload = { id: 1 }
      sig_header = '123'

      described_class.instance.process(payload: payload, sig_header: sig_header)

      expect(StripeAdapter.instance).to have_received(:process).with(payload: payload, sig_header: sig_header)
    end
  end
end
