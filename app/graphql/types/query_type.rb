# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :assistants, [ Types::UserType ], null: false

    def assistants
      User.assistant.all
    end
  end
end
