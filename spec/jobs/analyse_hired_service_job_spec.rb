# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnalyseHiredServiceJob do
  describe '#perform' do
    context 'when some error happens' do
      it 'raises an error' do
        Fabricate :hired_service, status: :analyzing, analysis_started_at: 25.hours.ago

        allow_any_instance_of(HiredServices::UpdateToDoneService).to receive(:update_to_done).and_raise(StandardError.new('Error'))

        expect { described_class.perform_sync }.to raise_error(StandardError, 'Error')
      end
    end

    context 'when no error happens' do
      it 'updates hired service to done' do
        hired_service = Fabricate :hired_service, status: :analyzing, analysis_started_at: 25.hours.ago

        described_class.perform_sync

        expect(hired_service.reload.status).to eq('done')
      end
    end
  end
end
