# frozen_string_literal: true

module AssistantServiceServices
  class UpdateService
    include Singleton

    def update(assistant_service_id:, attributes:)
      assistant_service = AssistantService.find(assistant_service_id)
      assistant_service.update!(attributes)
    end
  end
end
