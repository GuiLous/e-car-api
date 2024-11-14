# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantServices::ChangeToAssistantService do
  describe '#change_to_assistant' do
    it 'create assistant model' do
      user = Fabricate(:user)
      service = Fabricate(:service)

      described_class.instance.change_to_assistant(
        user_id: user.id,
        nickname: 'xpto',
        description: 'xpto',
        modality: 'live',
        price: 100,
        service_id: service.id
      )

      assistant = user.assistant.reload

      expect(assistant.nickname).to eq('xpto')
      expect(assistant.description).to eq('xpto')
      expect(assistant.status).to eq('pending')
      expect(assistant.assistant_services.first.modality).to eq('live')
      expect(assistant.assistant_services.first.price).to eq(100)
      expect(assistant.assistant_services.first.service_id).to eq(service.id)
    end
  end
end
