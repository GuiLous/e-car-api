# frozen_string_literal: true

module HireAssistantService
  class CreateService
    include Singleton

    def create(assistant_service_id:, schedule_date:)
      current_user = User.first

      assistant_service = ::AssistantService.find(assistant_service_id)

      raise Exceptions::InsufficientCoinsError if current_user.available_coins < assistant_service.price

      assistant_service.hire(date: schedule_date, user: current_user)
    end
  end
end
