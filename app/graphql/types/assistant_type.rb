# frozen_string_literal: true

module Types
  class AssistantType < Types::BaseObject
    field :description, String, null: true
    field :hired_services, [ Types::HiredServiceType ], null: true
    field :id, ID, null: false
    field :status, String, null: false
    field :user, Types::UserType, null: false
  end
end
