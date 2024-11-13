# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :assistant, Types::AssistantType, null: true
    field :description, String, null: true
    field :email, String, null: false
    field :id, ID, null: false
    field :name, String, null: false
    field :role, String, null: false
    field :wallet, Types::WalletType, null: false
  end
end
