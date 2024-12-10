# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EndSessionServiceJob do
  describe '#perform' do
    context 'when standard error happens' do
      it 'logger error' do
        session_service = Fabricate :session_service, status: :in_progress, end_at: 1.hour.ago

        allow(SessionService).to receive(:in_progress).and_return([ session_service ])
        allow(session_service).to receive(:update).and_raise(StandardError, 'Falha ao atualizar sessão')

        expect(Rails.logger).to receive(:error).with(/EndSessionServiceJob falhou: Falha ao atualizar sessão/)

        expect { described_class.new.perform }.to raise_error(StandardError, 'Falha ao atualizar sessão')
      end
    end

    context 'when no error happens' do
      it 'update status session to done' do
        session_service = Fabricate :session_service, status: :in_progress, end_at: 1.hour.ago

        described_class.new.perform

        expect(session_service.reload.status).to eq('done')
      end
    end
  end
end
