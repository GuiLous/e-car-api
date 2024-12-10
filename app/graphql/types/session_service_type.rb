# frozen_string_literal: true

module Types
  class SessionServiceType < Types::BaseObject
    field :assistant_channel_token, String
    field :assistant_channel_uid, String
    field :assistant_started_at, GraphQL::Types::ISO8601DateTime, null: true
    field :channel_name, String, null: false
    field :consumer_channel_token, String, null: false
    field :consumer_channel_uid, String, null: false
    field :consumer_started_at, GraphQL::Types::ISO8601DateTime, null: true
    field :end_at, GraphQL::Types::ISO8601DateTime, null: true
    field :hired_service, Types::HiredServiceType, null: true
    field :id, ID, null: false
    field :status, Enums::SessionStatusEnum, null: false
  end
end
