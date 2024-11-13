# frozen_string_literal: true

module Types
  class WalletType < Types::BaseObject
    field :available_coins, Integer, null: false
    field :blocked_coins, Integer, null: false
    field :id, ID, null: false
  end
end
