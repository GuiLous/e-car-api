# frozen_string_literal: true

module Types
  module Concerns
    module ServiceCategoryFields
      extend ActiveSupport::Concern

      included do
        field :service_categories, [ Types::ServiceCategoryType ], null: false
      end

      def service_categories
        authenticate_user!

        ServiceCategory.all
      end
    end
  end
end
