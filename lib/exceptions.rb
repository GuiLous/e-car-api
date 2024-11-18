# frozen_string_literal: true

module Exceptions
  class BaseError < StandardError
    def initialize(msg = default_message)
      super
    end

    private

    def default_message
      self.class::MESSAGE
    end
  end

  class SameUserError < BaseError
    MESSAGE = "SAME_USER_ERROR"
  end

  class InsufficientCoinsError < BaseError
    MESSAGE = "INSUFFICIENT_COINS"
  end

  class UserIsAlreadyAnAssistantError < BaseError
    MESSAGE = "USER_ALREADY_AN_ASSISTANT"
  end

  class InvalidCredentialsError < BaseError
    MESSAGE = "INVALID_CREDENTIALS"
  end

  class UserHasPendingSubmissionError < BaseError
    MESSAGE = "USER_HAS_PENDING_SUBMISSION"
  end
end
