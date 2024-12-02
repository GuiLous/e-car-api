# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include ::Authenticatable

    include Types::Concerns::UserFields
    include Types::Concerns::AssistantServiceFields
    include Types::Concerns::ServiceCategoryFields
    include Types::Concerns::AssistantFields
    include Types::Concerns::ServiceFields
  end
end
