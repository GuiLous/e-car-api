# frozen_string_literal: true

module Types
  class ProductFiltersType < Types::BaseInputObject
    argument :verified_status, Types::ProductStatusEnumType, required: false
  end
end
