# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantServiceServices::FindByIdService do
  describe '#find_by_id' do
    it 'finds an assistant service by id' do
      assistant_service = Fabricate :assistant_service

      result = described_class.instance.find_by_id(
        assistant_service_id: assistant_service.id
      )

      expect(result).to eq(assistant_service)
    end
  end
end
