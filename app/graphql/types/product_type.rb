# frozen_string_literal: true

module Types
  class ProductType < Types::BaseObject
    field :documentation_status, String, null: false
    field :id, ID, null: false
    field :images, [ Types::ImageType ], null: true
    field :mileage, Integer, null: false
    field :model, String, null: false
    field :vehicle_condition, String, null: false
    field :vehicle_name, String, null: false
    field :vehicle_type, String, null: false
    field :year, Integer, null: false
  end
end
