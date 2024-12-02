# frozen_string_literal: true

module Types
  module Concerns
    module UserFields
      extend ActiveSupport::Concern

      included do
        field :me, Types::UserType, null: true
      end

      def me
        context[:current_user]
      end
    end
  end
end
