# frozen_string_literal: true

module AssistantServices
  class ChangeToAssistantService
    include Singleton

    def change_to_assistant(user_id:, nickname:, description:, modality:, price:, service_id:, service_category_id:)
      ActiveRecord::Base.transaction do
        user = User.find(user_id)

        assistant = Assistant.new(user: user, nickname: nickname, description: description)

        raise ActiveRecord::RecordInvalid unless assistant.save

        assistant.reload

        assistant_service = AssistantService.new(assistant: assistant, service_id: service_id, modality: modality, price: price, service_category_id: service_category_id)

        raise ActiveRecord::RecordInvalid unless assistant_service.save
      end
    end
  end
end
