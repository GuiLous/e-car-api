# frozen_string_literal: true

module HiredServices
  class UpdateToAnalizingService
    include Singleton

    def update_to_analizing(hired_service_id:)
      hired_service = HiredService.find(hired_service_id)

      hired_service.update(status: :analyzing)
    end
  end
end
