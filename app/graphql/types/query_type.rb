# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :assistant_services, [ Types::AssistantServiceType ], null: false
    field :assistants, [ Types::AssistantType ], null: false
    field :me, Types::UserType, null: false

    def assistants
      Assistant.all
    end

    def assistant_services
      AssistantService.includes(:assistant, :service).all
    end

    def me
      User.find(1)
    end
  end
end
