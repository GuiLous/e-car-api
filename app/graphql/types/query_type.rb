# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include ::Authenticatable

    field :assistant_services, [ Types::AssistantServiceType ], null: false do
      argument :filters, Types::AssistantServiceFiltersType, required: false
    end

    field :assistants, [ Types::AssistantType ], null: false do
      argument :online, Boolean, required: false
    end

    field :assistant, Types::AssistantType, null: false do
      argument :id, ID, required: true
    end

    field :me, Types::UserType, null: true
    field :service_categories, [ Types::ServiceCategoryType ], null: false
    field :services, [ Types::ServiceType ], null: false

    def assistants(online: nil)
      assistants = Assistant.all

      assistants = assistants.joins(:user).where(users: { online_at: 3.minutes.ago..Time.current }) if online.present?

      assistants
    end

    def assistant(id:)
      assistant = Assistant.where(id: id).includes(:user).first

      return nil unless assistant
      
      assistant_services = AssistantService.joins(:assistant, :service).where({ assistant: assistant, visible: :visible })

      assistant.assistant_services = assistant_services
      
      assistant
    end

    def assistant_services(filters: nil)
      query = AssistantService.where(visible: true).includes(:assistant, :service)

      query = query.where(assistant_id: filters.assistant_id) if filters && filters.assistant_id.present?

      query.all
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
