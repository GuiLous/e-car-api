# frozen_string_literal: true

module AssistantServiceServices
  class UpdateStatusService
    include Singleton

    def update_status(assistant_service_id:, status:)
      assistant_service = AssistantService.find(assistant_service_id)

      assistant_service.update!(status: status)
    end
  end
end
