# frozen_string_literal: true

module Types
  class SessionType < Types::BaseObject
    field :hired_service, Types::HiredServiceType, null: true
    field :consumer_start_at, GraphQL::Types::ISO8601Date, null: true
    field :assistant_start_at, GraphQL::Types::ISO8601Date, null: true
    field :end_at, GraphQL::Types::ISO8601Date, null: true
    field :status, Enums::SessionStatusEnum, null: false
  end
end