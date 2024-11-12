# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Assistant do
  context 'associations' do
    it 'has many assistant_services' do
      assistant = Fabricate(:assistant)
      assistant_service = Fabricate(:assistant_service, assistant: assistant)
      expect(assistant.assistant_services).to include(assistant_service)
    end

    it 'has many services through assistant_services' do
      assistant = Fabricate(:assistant)
      service = Fabricate(:service)
      Fabricate(:assistant_service, assistant: assistant, service: service)
      expect(assistant.services).to include(service)
    end

    it 'belongs to a user' do
      assistant = Fabricate(:assistant)
      expect(assistant.user).to be_present
    end
  end
end
