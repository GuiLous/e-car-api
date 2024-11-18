# frozen_string_literal: true

module Mutations
  module UserMutations
    class SignUp < BaseMutation
      argument :email, String
      argument :name, String
      argument :password, String
      argument :password_confirmation, String
      argument :role, String, required: false, default_value: "customer"

      field :token, String, null: true

      def resolve(email:, password:, password_confirmation:, role:, name:)
        UserServices::CreatorService.instance.create(
          email: email,
          password: password,
          name: name,
          password_confirmation: password_confirmation,
          role: role
        )

        AuthServices::SignInService.instance.sign_in(email: email, password: password)
      end
    end
  end
end
