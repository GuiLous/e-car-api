# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wallet do
  context 'validations' do
    it 'is valid with valid attributes' do
      user = Fabricate(:user)
      wallet = user.wallet
      expect(wallet).to be_valid
    end
  end

  describe '#add_coins' do
    it 'adds coins to the wallet' do
      user = Fabricate(:user)
      user.wallet.add_coins(10)
      user.reload
      expect(user.wallet.coins).to eq(10)
    end
  end

  describe '#remove_coins' do
    it 'removes coins from the wallet' do
      user = Fabricate(:user)
      user.wallet.add_coins(10)
      user.wallet.remove_coins(5)
      user.reload
      expect(user.wallet.coins).to eq(5)
    end
  end

  describe '#blocked_coins' do
    context 'when there are no hired services' do
      it 'returns 0' do
        user = Fabricate :user
        wallet = user.wallet
        expect(wallet.blocked_coins).to eq(0)
      end
    end

    context 'when there are hired services' do
      it 'returns the sum of the prices of all scheduled hired services' do
        user = Fabricate :user
        wallet = user.wallet
        Fabricate(:hired_service, user: user, status: :scheduled, assistant_service: Fabricate(:assistant_service, price: 10))
        Fabricate(:hired_service, user: user, status: :scheduled, assistant_service: Fabricate(:assistant_service, price: 10))
        expect(wallet.blocked_coins).to eq(20)
      end
    end
  end

  describe '#available_coins' do
    context 'when there are no hired services' do
      it 'returns 100' do
        user = Fabricate(:user)
        wallet = user.wallet
        wallet.update(coins: 100)
        expect(wallet.available_coins).to eq(100)
      end
    end

    context 'when there are hired services' do
      it 'returns 50' do
        user = Fabricate(:user)
        wallet = user.wallet
        wallet.update(coins: 100)
        Fabricate(:hired_service, user: user, status: :scheduled, assistant_service: Fabricate(:assistant_service, price: 50))
        expect(wallet.available_coins).to eq(50)
      end
    end
  end
end
