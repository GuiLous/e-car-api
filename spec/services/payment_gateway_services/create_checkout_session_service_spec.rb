# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentGatewayServices::CreateCheckoutSessionService do
  describe '#create_checkout_session' do
    it 'create a checkout session' do
      fake_session = double('Stripe::Checkout::Session', id: '1', url: 'url') # rubocop:disable RSpec/VerifiedDoubles

      allow(StripeAdapter.instance).to receive(:create_checkout_session).and_return(fake_session)

      user = Fabricate :user

      price = 10.0
      price_id = '1'

      response = described_class.instance.create_checkout_session(price: price, price_id: price_id, current_user: user)

      expect(response[:session_url]).to be_present
      expect(response[:session_id]).to be_present
    end
  end
end
