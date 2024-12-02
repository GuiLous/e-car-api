# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantService do
  context 'validations' do
    it 'is valid with valid attributes' do
      assistant_service = Fabricate.build(:assistant_service)
      expect(assistant_service).to be_valid
    end

    it 'is invalid without a assistant' do
      assistant_service = Fabricate.build(:assistant_service, assistant: nil)
      expect(assistant_service).not_to be_valid
      expect(assistant_service.errors[:assistant]).to include('must exist')
    end

    it 'has a default price of 0' do
      assistant_service = Fabricate(:assistant_service)
      expect(assistant_service.price).to eq(0)
    end
  end

  context 'associations' do
    it 'belongs to a assistant' do
      assistant_service = Fabricate.create(:assistant_service)
      expect(assistant_service.assistant).to be_present
    end
  end
end
