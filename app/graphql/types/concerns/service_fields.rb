# frozen_string_literal: true

module Types
  module Concerns
    module ServiceFields
      extend ActiveSupport::Concern

      included do
        field :services, [ Types::ServiceType ], null: false
      end

      def services
        authenticate_user!

        Service.all
      end
    end
  end
end
