# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductServices::CreateService do
  describe '#create' do
    it 'creates product' do
      user = Fabricate(:user)

      result = described_class.instance.create(
        documentation_status: "up_to_date",
        mileage: 100,
        model: "xpto",
        vehicle_condition: "brand_new",
        vehicle_name: "xpto",
        vehicle_type: "car_type",
        year: 2024,
        user: user
      )

      expect(result[:message]).to be 'SUCCESS'
    end
  end
end
