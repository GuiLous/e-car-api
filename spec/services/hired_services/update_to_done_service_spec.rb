# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HiredServices::UpdateToDoneService do
  describe '#finish' do
    context 'when the hired service is not analyzing' do
      it 'does not update the status' do
        hired_service = Fabricate(:hired_service, status: :scheduled)
        result = described_class.instance.update_to_done(hired_service_id: hired_service.id)

        expect(result).to be_nil
      end
    end

    context 'when the hired service is analyzing' do
      it 'updates the status to finished' do
        hired_service = Fabricate(:hired_service, status: :analyzing)
        result = described_class.instance.update_to_done(hired_service_id: hired_service.id)

        expect(result).to be_truthy
      end
    end
  end
end
