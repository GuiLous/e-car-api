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

  class AssistantServiceAlreadyExistsError < BaseError
    MESSAGE = "ASSISTANT_SERVICE_ALREADY_EXISTS"
  end

  class SessionServiceAlreadyStarted< BaseError
    MESSAGE = "ALREADY_START"
  end

  class SessionServiceInProgress< BaseError
    MESSAGE = "IN_PROGRESS"
  end

  class SessionServiceNotFound< BaseError
    MESSAGE = "NOT_FOUND"
  end

  class HiredServiceItsNotLive< BaseError
    MESSAGE = "SERVICE_NOT_LIVE"
  end
  class HiredServiceNotFound < BaseError
    MESSAGE = "HIRED_SERVICE_NOT_FOUND"
  end
end
