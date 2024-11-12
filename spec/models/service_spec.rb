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
    it 'has many assistant_services' do
      service = Fabricate(:service)
      assistant_service = Fabricate(:assistant_service, service: service)
      expect(service.assistant_services).to include(assistant_service)
    end

    it 'has many assistants through assistant_services' do
      service = Fabricate(:service)
      assistant = Fabricate(:assistant)
      Fabricate(:assistant_service, service: service, assistant: assistant)
      expect(service.assistants).to include(assistant)
    end
  end
end
