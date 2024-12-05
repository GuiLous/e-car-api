# frozen_string_literal: true

module Types
  class SessionServiceType < Types::BaseObject
    field :id, ID,null: false
    field :assistant_started_at, GraphQL::Types::ISO8601DateTime, null: true
    field :consumer_started_at, GraphQL::Types::ISO8601DateTime, null: true
    field :end_at, GraphQL::Types::ISO8601DateTime, null: true
    field :hired_service, Types::HiredServiceType, null: true
    field :status, Enums::SessionStatusEnum, null: false
  end
end
