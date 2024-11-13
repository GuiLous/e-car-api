# frozen_string_literal: true

module HiredServices
  class UpdateToDoneService
    include Singleton

    def update_to_done(hired_service_id:)
      hired_service = HiredService.find(hired_service_id)

      return unless hired_service.status == "analyzing"

      assistant_service = hired_service.assistant_service

      consumer = hired_service.user

      price = assistant_service.price

      assistant_service.assistant.user.wallet.add_coins(price)
      consumer.wallet.remove_coins(price)

      hired_service.update!(status: :done)
    end
  end
end
