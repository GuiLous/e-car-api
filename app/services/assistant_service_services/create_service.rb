# frozen_string_literal: true

module AssistantServiceServices
  class CreateService
    include Singleton

    def create(title:, modality:, price:, service_category_id:, context:, description: nil)
      current_user = context[:current_user]

      if current_user.assistant.present?
        assistant_service_already_exists = current_user.assistant.assistant_services.find_by(
          service_category_id: service_category_id,
          price: price,
          modality: modality
        )
      end

      raise Exceptions::AssistantServiceAlreadyExistsError if assistant_service_already_exists.present?

      AssistantService.create!(
        modality: modality,
        price: price,
        service_category_id: service_category_id,
        title: title,
        description: description,
        assistant: current_user.assistant
      )
    end
  end
end
