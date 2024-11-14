# frozen_string_literal: true

module Mutations
  module AuthMutations
    class SignUp < BaseMutation
      include ::Authenticatable

      argument :email, String
      argument :name, String
      argument :password, String
      argument :password_confirmation, String
      argument :role, String, required: false, default_value: "member"

      field :user, Types::UserType, null: true

      def resolve(email:, password:, password_confirmation:, role:, name:)
        authenticate_user!

        result = UserServices::CreatorService.instance.create(
          email: email,
          password: password,
          name: name,
          password_confirmation: password_confirmation,
          role: role
        )

        { user: result }
      end
    end
  end
end
