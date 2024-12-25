# frozen_string_literal: true

module Types
  module Concerns
    module ProductFields
      extend ActiveSupport::Concern

      included do
        field :products, [ Types::ProductType ], null: false do
          argument :filters, Types::ProductFiltersType, required: false
          argument :order, Types::ProductOrderEnumType, required: false, default_value: "CREATED_AT_DESC"
          argument :page, Integer, required: false
          argument :per_page, Integer, required: false
        end
      end

      def products(filters: nil, order: "created_at_desc", page: 1, per_page: 10)
        query = Product.all

        query = apply_filters(query, filters)

        query = apply_order(query, order)
        query = query.page(page).per(per_page) if query.respond_to?(:page)
        query
      end

      private

      def apply_filters(query, filters)
        return query unless filters

        filter_by_status(query, filters)
      end

      def filter_by_status(query, filters)
        return query if filters.verified_status.blank?

        query.where(verified_status: filters.verified_status)
      end

      def apply_order(query, order)
        case order
        when "created_at_desc"
          query.order(created_at: :desc)
        when "created_at_asc"
          query.order(created_at: :asc)
        when "price_desc"
          query.order(price: :desc)
        when "price_asc"
          query.order(price: :asc)
        end
      end
    end
  end
end
