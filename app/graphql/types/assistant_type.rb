# frozen_string_literal: true

module Types
  class AssistantType < Types::BaseObject
    field :assistant_services, [ Types::AssistantServiceType ], null: true
    field :description, String, null: true
    field :hired_services, [ Types::HiredServiceType ], null: true
    field :id, ID, null: false
    field :user, Types::UserType, null: false
  end
end
