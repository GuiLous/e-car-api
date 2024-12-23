# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::ProductMutations::Create do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation(
          $documentationStatus: String!,
          $mileage: Int!,
          $model: String!,
          $vehicleCondition: String!,
          $vehicleName: String!,
          $vehicleType: String!,
          $year: Int!
        ) {
          createProduct(
            documentationStatus: $documentationStatus,
            mileage: $mileage,
            model: $model,
            vehicleCondition: $vehicleCondition,
            vehicleName: $vehicleName,
            vehicleType: $vehicleType,
            year: $year
          ) {
            message
          }
        }
      GQL
    end

    it 'returns success with image upload' do
      user = Fabricate :user

      variables = {
        documentationStatus: "up_to_date",
        mileage: 100,
        model: "xpto",
        vehicleCondition: "brand_new",
        vehicleName: "xpto",
        vehicleType: "car_type",
        year: 2024
      }

      context = { current_user: user }

      response = EcarSchema.execute(mutation, variables: variables, context: context).as_json
      data = response['data']['createProduct']

      expect(data['message']).to eq 'SUCCESS'
    end
  end
end
