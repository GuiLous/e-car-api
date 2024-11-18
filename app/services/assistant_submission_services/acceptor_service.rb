# frozen_string_literal: true

module AssistantSubmissionServices
  class AcceptorService
    include Singleton

    def accept(assistant_submission_id:)
      submission = AssistantSubmission.find(assistant_submission_id)
      submission.approved!

      Assistant.create!(user: submission.user, description: submission.description).tap do |assistant|
        if assistant.persisted?
          AssistantService.create!(assistant: assistant, service_id: submission.service_id, modality: submission.modality, price: submission.price,
                                   service_category_id: submission.service_category_id)
        end
      end
    end
  end
end
