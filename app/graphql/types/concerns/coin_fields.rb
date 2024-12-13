# frozen_string_literal: true

module Types
  module Concerns
    module CoinFields
      extend ActiveSupport::Concern

      included do
        field :coins, [ Types::CoinType ], null: false
      end

      def coins
        authenticate_user!

        products = Stripe::Product.list(active: true)

        product_list = products.data.map do |product|
          default_price = product.default_price
          price = Stripe::Price.retrieve(default_price)

          {
            id: product.id,
            name: product.name,
            price: price.unit_amount / 100.0,
            currency: price.currency,
            price_id: default_price
          }
        end

        product_list.sort_by { |product| product[:price] || Float::INFINITY }
      rescue Stripe::StripeError
        raise GraphQL::ExecutionError, "ERROR_FETCHING_PRODUCTS"
      end
    end
  end
end
