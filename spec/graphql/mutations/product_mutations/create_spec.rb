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

    context "when no errors occurs" do
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

    context "when errors occurs" do
      context "when user is not authenticated" do
        it 'raise UNAUTHORIZED' do
          variables = {
            documentationStatus: "up_to_date",
            mileage: 100,
            model: "xpto",
            vehicleCondition: "brand_new",
            vehicleName: "xpto",
            vehicleType: "car_type",
            year: 2024
          }

          response = EcarSchema.execute(mutation, variables: variables).as_json
          data = response['errors'][0]

          expect(data['message']).to eq 'UNAUTHORIZED'
        end
      end

      context "when an StandardError occurs" do
        it 'raise SYSTEM_ERROR' do
          allow(ProductServices::CreateService.instance).to receive(:create).and_raise(StandardError, 'SYSTEM_ERROR')

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
          data = response['errors'][0]

          expect(data['message']).to eq 'SYSTEM_ERROR'
        end
      end
    end
  end
end
