# frozen_string_literal: true

module Mutations
  module AssistantMutations
    class ChangeToAssistant < BaseMutation
      field :message, String, null: false

      argument :user_id, ID, required: true

      def resolve(user_id:)
        Assistants::ChangeToAssistant.instance.change_to_assistant(user_id: user_id)
        { message: "SUCCESS" }
      rescue StandardError
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
