# frozen_string_literal: true

module Mutations
  module UserMutations
    class UpdateUserStatus < BaseMutation
      argument :status, String, required: true

      field :user, Types::UserType, null: false

      def resolve(status:)
        user = context[:current_user]
        raise GraphQL::ExecutionError, "User not authenticated" unless user

        user.update!(status: status)
        { user: user }
      end
    end
  end
end
