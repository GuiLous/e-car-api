# frozen_string_literal: true

module Types
  module Concerns
    module AssistantFields
      extend ActiveSupport::Concern

      included do
        field :assistants, [ Types::AssistantType ], null: false do
          argument :online, GraphQL::Types::Boolean, required: false
        end

        field :assistant, Types::AssistantType, null: false do
          argument :id, GraphQL::Types::ID, required: true
        end
      end

      def assistants(online: nil)
        assistants = Assistant.all

        assistants = assistants.joins(:user).where(users: { online_at: 3.minutes.ago..Time.current }) if online.present?

        assistants
      end

      def assistant(id:)
        assistant = Assistant.includes(:user).includes(assistant_services: :service).find_by(id: id)

        return nil unless assistant

        assistant.assistant_services = assistant.assistant_services.where(visible: true)

        assistant
      end
    end
  end
end
