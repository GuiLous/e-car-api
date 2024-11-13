# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HiredServices::UpdateToAnalizingService do
  describe '#update_to_analizing' do
    it 'updates the hired service to analyzing' do
      hired_service = Fabricate(:hired_service)

      described_class.instance.update_to_analizing(hired_service_id: hired_service.id)

      expect(hired_service.reload.status).to eq('analyzing')
    end
  end
end
