# frozen_string_literal: true

module Types
  class CoinType < Types::BaseObject
    field :currency, String, null: false
    field :id, String, null: false
    field :name, String, null: false
    field :price, Float, null: false
    field :price_id, String, null: false
  end
end
