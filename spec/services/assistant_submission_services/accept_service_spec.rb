# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantSubmissionServices::AcceptService do
  describe '#accept' do
    it 'create assistant and assistant service' do
      user = Fabricate(:user)
      service = Fabricate(:service)
      service_category = Fabricate(:service_category)
      submission = Fabricate(:assistant_submission, user: user, status: :pending, description: 'xpto', service_id: service.id, modality: 0, price: 100, service_category_id: service_category.id)

      described_class.instance.accept(assistant_submission_id: submission.id)

      expect(submission.reload).to be_approved
      expect(user.assistant).not_to be_nil
      expect(user.assistant.description).to eq('xpto')
      expect(user.assistant.assistant_services.first.modality).to eq('live')
      expect(user.assistant.assistant_services.first.price).to eq(submission.price)
      expect(user.assistant.assistant_services.first.service_category_id).to eq(submission.service_category_id)
    end
  end
end
