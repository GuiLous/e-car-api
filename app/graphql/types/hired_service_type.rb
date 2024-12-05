# frozen_string_literal: true

module Types
  class HiredServiceType < Types::BaseObject
    field :analysis_started_at, GraphQL::Types::ISO8601DateTime, null: true
    field :assistant_service, Types::AssistantServiceType, null: false
    field :id, ID, null: false
    field :schedule_date, GraphQL::Types::ISO8601Date, null: false
    field :session_service, Types::SessionServiceType, null: true
    field :status, String, null: false
    field :user, Types::UserType, null: false
  end
end
