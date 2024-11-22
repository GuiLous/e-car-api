# frozen_string_literal: true

module AssistantServiceServices
  class UpdateVisibilityService
    include Singleton

    def update_visibility(assistant_service_id:, visible:)
      assistant_service = AssistantService.find(assistant_service_id)

      assistant_service.update!(visible: visible)
    end
  end
end
