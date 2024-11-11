# frozen_string_literal: true

module Types
  class ServiceType < Types::BaseObject
    field :description, String, null: true
    field :id, ID, null: false
    field :name, String, null: false
  end
end
