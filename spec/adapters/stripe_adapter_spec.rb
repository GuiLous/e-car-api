# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StripeAdapter do
  describe '#process' do
    let(:payload) { '{"event": "test_event"}' }
    let(:sig_header) { 'xpto' }

    context 'when no error occurs' do
      context "when event type is checkout session completed" do
        it "updates purchase status and add coins to wallet" do
          purchase = Fabricate :purchase
          user = purchase.user
          initial_coins = user.wallet.coins

          fake_event = {
            "data" => {
              "object" => {
                "id" => purchase.session_id
              }
            },
            "type" => "checkout.session.completed"
          }

          fake_line_items_response = double('LineItemsResponse', data: [ # rubocop:disable RSpec/VerifiedDoubles
                                              double('LineItem', description: '10.0') # rubocop:disable RSpec/VerifiedDoubles
                                            ])

          allow(Stripe::Webhook).to receive(:construct_event).and_return(fake_event)
          allow(Stripe::Checkout::Session).to receive(:list_line_items).with(purchase.session_id).and_return(fake_line_items_response)

          described_class.instance.process(payload: payload, sig_header: sig_header)

          expect(purchase.reload.status).to eq("paid")
          expect(user.reload.wallet.coins).to be(initial_coins + 1000)
        end
      end

      context "checkout session expired" do
        it "updates purchase status and add coins to wallet" do
          purchase = Fabricate :purchase
          user = purchase.user
          initial_coins = user.wallet.coins

          fake_event = {
            "data" => {
              "object" => {
                "id" => purchase.session_id
              }
            },
            "type" => "checkout.session.expired"
          }

          allow(Stripe::Webhook).to receive(:construct_event).and_return(fake_event)

          described_class.instance.process(payload: payload, sig_header: sig_header)

          expect(purchase.reload.status).to eq("cancelled")
          expect(user.reload.wallet.coins).to be(initial_coins)
        end
      end
    end

    context 'when errors occurs' do
      context "when an JSON::ParserError occurs" do
        it 'logs an error when there is a JSON::ParserError' do
          allow(Stripe::Webhook).to receive(:construct_event).and_raise(JSON::ParserError)

          expect(Rails.logger).to receive(:error).with('Stripe webhook: Invalid payload')

          described_class.instance.process(payload: payload, sig_header: sig_header)
        end
      end
    end
  end

  describe '#create_checkout_session' do
    it 'create a stripe checkout session' do
      fake_session = {
        "id" => "1",
        "url" => "url"
      }

      allow(Stripe::Checkout::Session).to receive(:create).and_return(fake_session)

      response = described_class.instance.create_checkout_session(price_id: '1')

      expect(response["id"]).to be_present
      expect(response["url"]).to be_present
    end
  end
end
