# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :assistant_services, [ Types::AssistantServiceType ], null: false
    field :assistants, [ Types::AssistantType ], null: false
    field :me, Types::UserType, null: false
    field :service_categories, [ Types::ServiceCategoryType ], null: false
    field :services, [ Types::ServiceType ], null: false

    def assistants
      Assistant.all
    end

    def assistant_services
      AssistantService.includes(:assistant, :service).all
    end

    def services
      Service.all
    end

    def service_categories
      ServiceCategory.all
    end

    def me
      User.find(ENV.fetch("LOGGED_USER_ID"))
    end
  end
end
