# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :blocked_coins, Integer, null: false
    field :description, String, null: true
    field :email, String, null: false
    field :id, ID, null: false
    field :name, String, null: false
    field :role, String, null: false
  end
end
