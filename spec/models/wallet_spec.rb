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
end
