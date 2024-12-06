# frozen_string_literal: true

module Types
  module Concerns
    module HiredServiceFields
      extend ActiveSupport::Concern

      included do
        field :hired_services_by_user, [ HiredServiceType ], null: false
      end

      def hired_services_by_user
        authenticate_user!
        current_user = context[:current_user]
        HiredService.where(user_id: current_user.id).order(id: :desc).all
      end
    end
  end
end
