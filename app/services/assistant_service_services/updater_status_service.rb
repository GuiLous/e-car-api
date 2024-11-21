# frozen_string_literal: true

module AssistantServiceServices
  class UpdaterStatusService
    include Singleton

    def updater_status(assistant_service_id:, status:)
      assistant_service = AssistantService.find(assistant_service_id)

      assistant_service.update!(status: status)
    end
  end
end
