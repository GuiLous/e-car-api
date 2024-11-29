# frozen_string_literal: true

module AssistantServiceServices
  class FindByIdService
    include Singleton

    def find_by_id(assistant_service_id:)
      AssistantService.find(assistant_service_id)
    end
  end
end
