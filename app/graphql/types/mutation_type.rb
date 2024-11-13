# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Hired Services
    field :finish_hired_service, mutation: Mutations::HiredServiceMutations::FinishHiredService
    field :hire_assistant, mutation: Mutations::HiredServiceMutations::HireAssistant
  end
end
