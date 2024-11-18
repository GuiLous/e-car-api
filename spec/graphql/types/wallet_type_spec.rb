# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::WalletType do
  describe 'WalletType' do
    let(:query) do
      <<~GQL
        query {
          me {
            wallet {
              id
              availableCoins
              blockedCoins
            }
          }
        }
      GQL
    end

    it 'returns the expected fields for a user' do
      user = Fabricate :user
      wallet = user.wallet

      context = { current_user: user }

      response = ProladdoreSchema.execute(query, context: context).as_json
      data = response['data']['me']['wallet']

      expect(data['id']).to eq(wallet.id.to_s)
      expect(data['availableCoins']).to eq(wallet.available_coins)
      expect(data['blockedCoins']).to eq(wallet.blocked_coins)
    end
  end
end
