# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service do
  context 'validations' do
    it 'is valid with valid attributes' do
      service = Fabricate.build(:service)
      expect(service).to be_valid
    end

    it 'is invalid without a name' do
      service = Fabricate.build(:service, name: nil)
      expect(service).not_to be_valid
      expect(service.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a description' do
      service = Fabricate.build(:service, description: nil)
      expect(service).not_to be_valid
      expect(service.errors[:description]).to include("can't be blank")
    end
  end

  context 'associations' do
    it 'has many user_services' do
      service = Fabricate(:service)
      user_service = Fabricate(:user_service, service: service)
      expect(service.user_services).to include(user_service)
    end

    it 'has many users through user_services' do
      service = Fabricate(:service)
      user = Fabricate(:user)
      Fabricate(:user_service, service: service, user: user)
      expect(service.users).to include(user)
    end
  end
end
