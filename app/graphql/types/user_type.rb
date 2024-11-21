# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :assistant, Types::AssistantType, null: true
    field :assistant_services, [ Types::AssistantServiceType ], null: true
    field :assistant_submission, Types::AssistantSubmissionType, null: true
    field :description, String, null: true
    field :email, String, null: false
    field :id, ID, null: false
    field :name, String, null: false
    field :role, String, null: false
    field :wallet, Types::WalletType, null: false

    def assistant_submission
      AssistantSubmission.last
    end

    def assistant_services
      object.assistant.assistant_services
    end
  end
end
