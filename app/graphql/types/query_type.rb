# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include ::Authenticatable

    include Types::Concerns::UserFields
    include Types::Concerns::AssistantServiceFields
    include Types::Concerns::ServiceCategoryFields
    include Types::Concerns::AssistantFields
    include Types::Concerns::ServiceFields
    include Types::Concerns::SessionServiceFields
    include Types::Concerns::HiredServiceFields
  end
end
