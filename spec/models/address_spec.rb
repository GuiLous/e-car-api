# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address do
  context 'validations' do
    it 'is valid with valid attributes' do
      address = Fabricate.build(:address)
      expect(address).to be_valid
    end

    it 'is invalid without a city' do
      address = Fabricate.build(:address, city: nil)
      expect(address).not_to be_valid
      expect(address.errors[:city]).to include("can't be blank")
    end

    it 'is invalid without a country' do
      address = Fabricate.build(:address, country: nil)
      expect(address).not_to be_valid
      expect(address.errors[:country]).to include("can't be blank")
    end

    it 'is invalid without a formatted_address' do
      address = Fabricate.build(:address, formatted_address: nil)
      expect(address).not_to be_valid
      expect(address.errors[:formatted_address]).to include("can't be blank")
    end

    it 'is invalid without a latitude' do
      address = Fabricate.build(:address, latitude: nil)
      expect(address).not_to be_valid
      expect(address.errors[:latitude]).to include("can't be blank")
    end

    it 'is invalid without a longitude' do
      address = Fabricate.build(:address, longitude: nil)
      expect(address).not_to be_valid
      expect(address.errors[:longitude]).to include("can't be blank")
    end

    it 'is invalid without a neighborhood' do
      address = Fabricate.build(:address, neighborhood: nil)
      expect(address).not_to be_valid
      expect(address.errors[:neighborhood]).to include("can't be blank")
    end

    it 'is invalid without a number' do
      address = Fabricate.build(:address, number: nil)
      expect(address).not_to be_valid
      expect(address.errors[:number]).to include("can't be blank")
    end

    it 'is invalid without a postal_code' do
      address = Fabricate.build(:address, postal_code: nil)
      expect(address).not_to be_valid
      expect(address.errors[:postal_code]).to include("can't be blank")
    end

    it 'is invalid without a state' do
      address = Fabricate.build(:address, state: nil)
      expect(address).not_to be_valid
      expect(address.errors[:state]).to include("can't be blank")
    end

    it 'is invalid without a street' do
      address = Fabricate.build(:address, street: nil)
      expect(address).not_to be_valid
      expect(address.errors[:street]).to include("can't be blank")
    end
  end
end
