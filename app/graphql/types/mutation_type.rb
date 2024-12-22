# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Auth
    field :sign_in, mutation: Mutations::AuthMutations::SignIn

    # User
    field :sign_up, mutation: Mutations::UserMutations::SignUp
  end
end
