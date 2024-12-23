# frozen_string_literal: true

module Types
  module Concerns
    module ProductFields
      extend ActiveSupport::Concern

      included do
        field :products, [ Types::ProductType ], null: false
      end

      def products
        Product.all
      end
    end
  end
end
