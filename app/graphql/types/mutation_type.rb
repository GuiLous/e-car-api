# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Hired Service
    field :finish_hired_service, mutation: Mutations::HiredServiceMutations::FinishHiredService
    field :hire_assistant, mutation: Mutations::HiredServiceMutations::HireAssistant

    # Assistant
    field :change_to_assistant, mutation: Mutations::AssistantMutations::ChangeToAssistant
  end
end
