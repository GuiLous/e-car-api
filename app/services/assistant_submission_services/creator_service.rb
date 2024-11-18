# frozen_string_literal: true

module AssistantSubmissionServices
class CreatorService
  include Singleton

  def create(user:, description:, modality:, price:, service_id:, service_category_id:)
    raise Exceptions::UserHasPendingSubmissionError if user.assistant_submissions.last&.pending?
    raise Exceptions::UserIsAlreadyAnAssistantError if user.assistant.present?

    user.assistant_submissions.create(user: user, description: description, status: :pending, service_id: service_id, modality: modality, price: price, service_category_id: service_category_id)
  end
end
end
