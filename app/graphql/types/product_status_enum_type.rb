# frozen_string_literal: true

module Types
  class ProductStatusEnumType < Types::BaseEnum
    value "PENDING", "", value: "pending"
    value "APPROVED", "", value: "approved"
    value "REPROVED", "", value: "reproved"
  end
end
