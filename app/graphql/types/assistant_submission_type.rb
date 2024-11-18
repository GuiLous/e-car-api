# frozen_string_literal: true

module Types
  class AssistantSubmissionType < Types::BaseObject
    field :description, String, null: false
    field :id, ID, null: false
    field :modality, String, null: false
    field :price, Integer, null: false
    field :service, Types::ServiceType, null: false
    field :service_category, Types::ServiceCategoryType, null: false
    field :status, String, null: false
    field :user, Types::UserType, null: false
  end
end
