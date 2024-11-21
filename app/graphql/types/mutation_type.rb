# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Auth
    field :sign_in, mutation: Mutations::AuthMutations::SignIn

    # User
    field :sign_up, mutation: Mutations::UserMutations::SignUp

    # Hired Service
    field :finish_hired_service, mutation: Mutations::HiredServiceMutations::FinishHiredService
    field :hire_assistant, mutation: Mutations::HiredServiceMutations::HireAssistant

    # Assistant
    field :submit_assistant, mutation: Mutations::AssistantMutations::SubmitAssistant

    # Assistant Service
    field :add_assistant_service, mutation: Mutations::AssistantServiceMutations::Add
    field :update_status, mutation: Mutations::AssistantServiceMutations::UpdateStatus
  end
end
