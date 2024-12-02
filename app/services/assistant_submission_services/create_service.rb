# frozen_string_literal: true

module AssistantSubmissionServices
class CreateService
  include Singleton

  def create(user:, title:, description:, modality:, price:, service_category_id:)
    raise Exceptions::UserHasPendingSubmissionError if user.assistant_submissions.last&.pending?
    raise Exceptions::UserIsAlreadyAnAssistantError if user.assistant.present?

    user.assistant_submissions.create(user: user, title: title, description: description, status: :pending, service_category_id: service_category_id, modality: modality, price: price)
  end
end
end
