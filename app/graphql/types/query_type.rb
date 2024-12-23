# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include ::Authenticatable

    include Types::Concerns::UserFields
    include Types::Concerns::ProductFields
  end
end
