# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include ::Authenticatable

    field :assistant_services, [ Types::AssistantServiceType ], null: false
    field :assistants, [ Types::AssistantType ], null: false
    field :me, Types::UserType, null: true
    field :service_categories, [ Types::ServiceCategoryType ], null: false
    field :services, [ Types::ServiceType ], null: false

    def assistants
      Assistant.all
    end

    def assistant_services
      AssistantService.where(status: "active").includes(:assistant, :service).all
    end

    def services
      authenticate_user!

      Service.all
    end

    def service_categories
      authenticate_user!

      ServiceCategory.all
    end

    def me
      context[:current_user]
    end
  end
end
