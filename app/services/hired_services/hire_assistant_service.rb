# frozen_string_literal: true

module HiredServices
  class HireAssistantService
    include Singleton

    def hire(assistant_service_id:, schedule_date:, context:)
      current_user = context[:current_user]
      assistant_service = AssistantService.find(assistant_service_id)

      raise Exceptions::InsufficientCoinsError if current_user.wallet.available_coins < assistant_service.price

      raise Exceptions::SameUserError if current_user == assistant_service.assistant.user

      assistant_service.hire(date: schedule_date, user: current_user)
    end
  end
end
