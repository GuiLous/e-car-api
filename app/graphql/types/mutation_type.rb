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
    field :update_assistant_service, mutation: Mutations::AssistantServiceMutations::Update
    field :update_visibility, mutation: Mutations::AssistantServiceMutations::UpdateVisibility

    # Session Service
    field :start_session_service, mutation: Mutations::SessionServiceMutations::StartSession
  end
end
