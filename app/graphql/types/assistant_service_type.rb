# frozen_string_literal: true

module Types
  class AssistantServiceType < Types::BaseObject
    field :assistant, Types::AssistantType, null: false
    field :description, String, null: true
    field :id, ID, null: false
    field :image_url, String, null: true
    field :modality, Enums::ModalityEnum, null: false
    field :price, Integer, null: false
    field :service_category, Types::ServiceCategoryType, null: false
    field :visible, Boolean, null: false

    def visible
      object.visible == "visible"
    end

    def image_url
      object.service_category&.image_url
    end
  end
end
