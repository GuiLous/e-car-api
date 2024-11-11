# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :assistant_services, [ Types::AssistantServiceType ], null: false
    field :assistants, [ Types::UserType ], null: false

    def assistants
      User.assistant.all
    end

    def assistant_services
      UserService.includes(:user, :service).all
    end
  end
end
