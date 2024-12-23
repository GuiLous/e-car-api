# frozen_string_literal: true

module Mutations
  module UserMutations
    class SignUp < BaseMutation
      argument :email, String
      argument :first_name, String
      argument :last_name, String
      argument :password, String
      argument :password_confirmation, String
      argument :phone, String

      field :token, String, null: true

      def resolve(email:, first_name:, last_name:, phone:, password:, password_confirmation:)
        UserServices::CreateService.instance.create(
          email: email,
          first_name: first_name,
          last_name: last_name,
          phone: phone,
          password: password,
          password_confirmation: password_confirmation
        )

        AuthServices::SignInService.instance.sign_in(email: email, password: password)
      rescue StandardError
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
