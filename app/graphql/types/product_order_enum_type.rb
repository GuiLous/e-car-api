# frozen_string_literal: true

module Types
  class ProductOrderEnumType < Types::BaseEnum
    value "CREATED_AT_DESC", "Order by created_at descending", value: "created_at_desc"
    value "CREATED_AT_ASC", "Order by created_at ascending", value: "created_at_asc"
    value "PRICE_DESC", "Order by price descending", value: "price_desc"
    value "PRICE_ASC", "Order by price ascending", value: "price_asc"
  end
end
