# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantServiceServices::UpdateVisibilityService do
  describe '#update_visibility' do
    it 'updates visibility of an assistant service to hidden' do
      assistant_service = Fabricate :assistant_service

      described_class.instance.update_visibility(
        assistant_service_id: assistant_service.id,
        visible: 'hidden'
      )

      expect(assistant_service.reload.visible).to eq('hidden')
    end

    it 'updates the visibility of an assistant service to visible' do
      assistant_service = Fabricate :assistant_service, visible: 'hidden'

      described_class.instance.update_visibility(
        assistant_service_id: assistant_service.id,
        visible: 'visible'
      )

      expect(assistant_service.reload.visible).to eq('visible')
    end
  end
end
