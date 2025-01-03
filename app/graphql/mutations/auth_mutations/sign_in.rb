# frozen_string_literal: true

module Mutations
  module AuthMutations
    class SignIn < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :token, String, null: true
      field :user, Types::UserType, null: true

      def resolve(email:, password:)
        AuthServices::SignInService.instance.sign_in(email: email, password: password)
      rescue Exceptions::InvalidCredentialsError => e
        raise GraphQL::ExecutionError, e.message
      rescue StandardError
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
