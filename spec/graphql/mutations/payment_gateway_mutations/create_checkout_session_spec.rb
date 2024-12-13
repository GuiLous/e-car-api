# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::PaymentGatewayMutations::CreateCheckoutSession do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation($price: Float!, $priceId: String!) {
          createCheckoutSession(price: $price, priceId: $priceId) {
            sessionId
            sessionUrl
          }
        }
      GQL
    end

    context 'when no error occurs' do
      it 'calls the mutation' do
        allow(ProladdoreSchema).to receive(:execute).and_return({ 'data' => { 'createCheckoutSession' => { 'sessionId' => '1', 'sessionUrl' => 'url' } } })

        user = Fabricate :user

        variables = {
          price: 10.0,
          priceId: '1'
        }

        context = { current_user: user }

        ProladdoreSchema.execute(mutation, variables: variables, context: context)

        expect(ProladdoreSchema).to have_received(:execute).with(mutation, variables: variables, context: context)
      end
    end

    context 'when a StandardError is raised' do
      it 'returns a system error' do
        allow(PaymentGatewayServices::CreateCheckoutSessionService.instance).to receive(:create_checkout_session).and_raise(StandardError, 'SYSTEM_ERROR')

        user = Fabricate :user

        variables = {
          price: 10.0,
          priceId: '1'
        }

        context = { current_user: user }

        response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json
        error_message = response['errors'].first['message']

        expect(error_message).to eq('SYSTEM_ERROR')
      end
    end
  end
end
