# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :description, String, null: true
    field :email, String, null: false
    field :id, ID, null: false
    field :name, String, null: false
    field :role, String, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
