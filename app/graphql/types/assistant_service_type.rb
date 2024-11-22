# frozen_string_literal: true

module Types
  class AssistantServiceType < Types::BaseObject
    field :assistant, Types::AssistantType, null: false
    field :id, ID, null: false
    field :price, Integer, null: false
    field :service, Types::ServiceType, null: false
    field :visible, Boolean, null: false

    def visible
      object.visible == "visible"
    end
  end
end
