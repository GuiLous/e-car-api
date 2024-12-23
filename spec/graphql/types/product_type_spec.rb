# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::ProductType do
  describe 'ProductType' do
    let(:query) do
      <<~GQL
        query {
          products {
            documentationStatus
            id
            mileage
            model
            vehicleCondition
            vehicleName
            vehicleType
            year
            images {
              filename
            }
          }
        }
      GQL
    end

    it 'returns the expected fields for a product' do
      Fabricate :product

      response = EcarSchema.execute(query).as_json
      data = response['data']['products']

      expect(data.length).to be > 0
    end
  end
end
