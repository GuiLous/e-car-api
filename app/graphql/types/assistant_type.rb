# frozen_string_literal: true

module Types
  class AssistantType < Types::BaseObject
    field :description, String, null: true
    field :id, ID, null: false
    field :nickname, String, null: false
    field :user, Types::UserType, null: false
  end
end
