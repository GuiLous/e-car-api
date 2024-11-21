# frozen_string_literal: true

module AssistantServiceServices
  class CreateService
    include Singleton

    def create(modality:, price:, service_id:, service_category_id:, context:)
      current_user = context[:current_user]

      assistant_service_already_exists = current_user.assistant.assistant_services.find_by(
        service_id: service_id,
        service_category_id: service_category_id,
        price: price,
        modality: modality
      )

      raise Exceptions::AssistantServiceAlreadyExistsError if assistant_service_already_exists.present?

      AssistantService.create!(
        modality: modality,
        price: price,
        service_id: service_id,
        service_category_id: service_category_id,
        assistant: current_user.assistant
      )
    end
  end
end
