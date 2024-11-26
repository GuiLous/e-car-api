# frozen_string_literal: true

module Types
  class AssistantServiceType < Types::BaseObject
    field :assistant, Types::AssistantType, null: false
    field :id, ID, null: false
    field :image_url, String, null: true
    field :price, Integer, null: false
    field :service, Types::ServiceType, null: false
    field :visible, Boolean, null: false

    def visible
      object.visible == "visible"
    end

    def image_url
      object.service_category&.image_url
    end
  end
end
