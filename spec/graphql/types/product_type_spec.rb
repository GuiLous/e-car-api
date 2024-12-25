# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::ProductType do
  describe 'ProductType' do
    let(:query) do
      <<~GQL
        query($filters: ProductFilters, $order: ProductOrderEnum) {
          products(filters: $filters, order: $order) {
            documentationStatus
            id
            mileage
            model
            vehicleCondition
            vehicleName
            vehicleType
            year
            verifiedStatus
            createdAt
            images {
              filename
            }
          }
        }
      GQL
    end

    context 'when no filters are applied' do
      it 'returns all approved products' do
        Fabricate :product, verified_status: :approved
        Fabricate :product, verified_status: :reproved

        response = EcarSchema.execute(query).as_json
        data = response['data']['products']

        expect(data.length).to be 2
        expect(data.first['verifiedStatus']).to eq('reproved')
        expect(data.last['verifiedStatus']).to eq('approved')
      end
    end

    context 'when filtering by verified_status' do
      it 'returns only pending products' do
        Fabricate :product
        Fabricate :product, verified_status: :approved
        Fabricate :product, verified_status: :reproved

        variables = { filters: { verifiedStatus: 'PENDING' } }

        response = EcarSchema.execute(query, variables: variables).as_json
        data = response['data']['products']

        expect(data.length).to be 1
        expect(data).to(be_all { |product| product['verifiedStatus'] == 'pending' })
      end

      it 'returns only approved products' do
        Fabricate :product, verified_status: :approved
        Fabricate :product, verified_status: :reproved

        variables = { filters: { verifiedStatus: 'APPROVED' } }

        response = EcarSchema.execute(query, variables: variables).as_json
        data = response['data']['products']

        expect(data.length).to be > 0
        expect(data).to(be_all { |product| product['verifiedStatus'] == 'approved' })
      end

      it 'returns only rejected products' do
        Fabricate :product, verified_status: :approved
        Fabricate :product, verified_status: :reproved

        variables = { filters: { verifiedStatus: 'REPROVED' } }

        response = EcarSchema.execute(query, variables: variables).as_json
        data = response['data']['products']

        expect(data.length).to be > 0
        expect(data).to(be_all { |product| product['verifiedStatus'] == 'reproved' })
      end
    end

    context 'when ordering by CREATED_AT_DESC' do
      it 'returns products ordered by CREATED_AT_DESC' do
        product1 = Fabricate(:product, created_at: 2.days.ago, verified_status: :approved)
        product2 = Fabricate(:product, created_at: 1.day.ago, verified_status: :approved)
        product3 = Fabricate(:product, created_at: 3.days.ago, verified_status: :reproved)

        variables = { order: 'CREATED_AT_DESC' }

        response = EcarSchema.execute(query, variables: variables).as_json
        data = response['data']['products']

        expect(data.length).to be 3
        expect(data.first['createdAt']).to eq(product2.created_at.iso8601)
        expect(data.second['createdAt']).to eq(product1.created_at.iso8601)
        expect(data.last['createdAt']).to eq(product3.created_at.iso8601)
      end
    end

    context 'when ordering by CREATED_AT_ASC' do
      it 'returns products ordered by CREATED_AT_ASC' do
        product1 = Fabricate(:product, created_at: 2.days.ago, verified_status: :approved)
        product2 = Fabricate(:product, created_at: 1.day.ago, verified_status: :approved)
        product3 = Fabricate(:product, created_at: 3.days.ago, verified_status: :reproved)

        variables = { order: 'CREATED_AT_ASC' }

        response = EcarSchema.execute(query, variables: variables).as_json
        data = response['data']['products']

        expect(data.length).to be 3
        expect(data.first['createdAt']).to eq(product3.created_at.iso8601)
        expect(data.second['createdAt']).to eq(product1.created_at.iso8601)
        expect(data.last['createdAt']).to eq(product2.created_at.iso8601)
      end
    end

    context 'when ordering by PRICE_DESC' do
      it 'returns products ordered by PRICE_DESC' do
        product1 = Fabricate(:product, price: 102.0, verified_status: :approved)
        product2 = Fabricate(:product, price: 101.0, verified_status: :approved)
        product3 = Fabricate(:product, price: 103.0, verified_status: :reproved)

        variables = { order: 'PRICE_DESC' }

        response = EcarSchema.execute(query, variables: variables).as_json
        data = response['data']['products']

        expect(data.length).to be 3
        expect(data.first['createdAt']).to eq(product3.created_at.iso8601)
        expect(data.second['createdAt']).to eq(product1.created_at.iso8601)
        expect(data.last['createdAt']).to eq(product2.created_at.iso8601)
      end
    end

    context 'when ordering by PRICE_ASC' do
      it 'returns products ordered by PRICE_ASC' do
        product1 = Fabricate(:product, price: 102.0, verified_status: :approved)
        product2 = Fabricate(:product, price: 101.0, verified_status: :approved)
        product3 = Fabricate(:product, price: 103.0, verified_status: :reproved)

        variables = { order: 'PRICE_ASC' }

        response = EcarSchema.execute(query, variables: variables).as_json
        data = response['data']['products']

        expect(data.length).to be 3
        expect(data.first['createdAt']).to eq(product2.created_at.iso8601)
        expect(data.second['createdAt']).to eq(product1.created_at.iso8601)
        expect(data.last['createdAt']).to eq(product3.created_at.iso8601)
      end
    end
  end
end
