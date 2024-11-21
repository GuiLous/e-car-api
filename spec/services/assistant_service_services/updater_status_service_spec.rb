# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantServiceServices::UpdaterStatusService do
  describe '#updater_status' do
    it 'updates the status of an assistant service to inactive' do
      assistant_service = Fabricate :assistant_service

      described_class.instance.updater_status(
        assistant_service_id: assistant_service.id,
        status: 'inactive'
      )

      expect(assistant_service.reload.status).to eq('inactive')
    end

    it 'updates the status of an assistant service to active' do
      assistant_service = Fabricate :assistant_service, status: 'inactive'

      described_class.instance.updater_status(
        assistant_service_id: assistant_service.id,
        status: 'active'
      )

      expect(assistant_service.reload.status).to eq('active')
    end
  end
end
