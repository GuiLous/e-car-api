# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product do
  context 'validations' do
    it 'is valid with valid attributes' do
      product = Fabricate.build(:product)
      expect(product).to be_valid
    end

    it 'is invalid without a vehicle_name' do
      product = Fabricate.build(:product, vehicle_name: nil)
      expect(product).not_to be_valid
      expect(product.errors[:vehicle_name]).to include("can't be blank")
    end

    it 'is invalid without a year' do
      product = Fabricate.build(:product, year: nil)
      expect(product).not_to be_valid
      expect(product.errors[:year]).to include("can't be blank")
    end

    it 'is invalid without a mileage' do
      product = Fabricate.build(:product, mileage: nil)
      expect(product).not_to be_valid
      expect(product.errors[:mileage]).to include("can't be blank")
    end

    it 'is invalid without a model' do
      product = Fabricate.build(:product, model: nil)
      expect(product).not_to be_valid
      expect(product.errors[:model]).to include("can't be blank")
    end
  end
end
