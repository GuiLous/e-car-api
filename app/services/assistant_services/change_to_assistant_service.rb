# frozen_string_literal: true

module AssistantServices
  class ChangeToAssistantService
    include Singleton

    def change_to_assistant(user_id:)
      user = User.find(user_id)

      raise ActiveRecord::RecordInvalid unless user.save

      Wallet.create(user: user)
      user
    end
  end
end
