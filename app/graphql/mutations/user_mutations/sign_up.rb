# frozen_string_literal: true

module Mutations
  module UserMutations
    class SignUp < BaseMutation
      argument :email, String
      argument :name, String
      argument :password, String
      argument :password_confirmation, String

      field :token, String, null: true

      def resolve(email:, password:, password_confirmation:, name:)
        UserServices::CreateService.instance.create(
          email: email,
          password: password,
          name: name,
          password_confirmation: password_confirmation
        )

        AuthServices::SignInService.instance.sign_in(email: email, password: password)
      end
    end
  end
end
