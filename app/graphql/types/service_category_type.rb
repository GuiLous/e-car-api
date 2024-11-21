# frozen_string_literal: true

module Types
  class ServiceCategoryType < Types::BaseObject
    field :id, ID, null: false
    field :image_url, String, null: true
    field :name, String, null: false
    field :type_category, String, null: true
  end
end
