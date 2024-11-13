# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HiredService do
  context 'validations' do
    it 'is valid with valid attributes' do
      hired_service = Fabricate.build(:hired_service)
      expect(hired_service).to be_valid
    end
  end

  describe '#update_analysis_started_at' do
    context 'when status is changed to analyzing' do
      it 'updates the analysis_started_at' do
        hired_service = Fabricate(:hired_service)
        hired_service.update(status: :analyzing)

        expect(hired_service.analysis_started_at).to be_present
      end

      it 'does not update the analysis_started_at if the status is not analyzing' do
        hired_service = Fabricate(:hired_service)
        hired_service.update(status: :scheduled)

        expect(hired_service.analysis_started_at).to be_nil
      end
    end
  end

  describe '.analysis_finished' do
    context 'when the analysis started more or equalthan 24 hours ago' do
      it 'returns the hired services' do
        Fabricate(:hired_service, status: :analyzing, analysis_started_at: 24.hours.ago)
        Fabricate(:hired_service, status: :analyzing, analysis_started_at: 25.hours.ago)
        Fabricate(:hired_service, status: :analyzing, analysis_started_at: 12.hours.ago)
        Fabricate(:hired_service)

        expect(described_class.analysis_finished.length).to eq(2)
      end
    end
  end
end
