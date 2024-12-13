# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::CoinType do
  describe 'CoinType' do
    let(:query) do
      <<~GQL
        query {
          coins {
            id
            currency
            name
            price
            priceId
          }
        }
      GQL
    end

    context 'when no errors occurs' do
      it 'returns the expected fields for a coin' do
        fake_product = double( # rubocop:disable RSpec/VerifiedDoubles
          'Stripe::Product',
          id: 'prod_123',
          name: 'Product 1',
          default_price: 'price_123'
        )

        fake_price = double( # rubocop:disable RSpec/VerifiedDoubles
          'Stripe::Price',
          unit_amount: 1000,
          currency: 'usd'
        )

        allow(Stripe::Product).to receive(:list).and_return(
          double(Stripe::ListObject, data: [ fake_product ]) # rubocop:disable RSpec/VerifiedDoubles
        )

        allow(Stripe::Price).to receive(:retrieve).and_return(fake_price)

        user = Fabricate :user

        context = { current_user: user }

        response = ProladdoreSchema.execute(query, context: context).as_json
        data = response['data']['coins']

        expect(data.length).to be 1
      end
    end

    context 'when an Stripe::StripeError occurs' do
      it 'raise ERROR_FETCHING_PRODUCTS error' do
        allow(Stripe::Product).to receive(:list).and_raise(Stripe::StripeError)

        user = Fabricate :user

        context = { current_user: user }

        response = ProladdoreSchema.execute(query, context: context).as_json
        data = response['errors'][0]

        expect(data['message']).to be 'ERROR_FETCHING_PRODUCTS'
      end
    end
  end
end
