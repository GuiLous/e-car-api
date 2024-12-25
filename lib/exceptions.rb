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

  class InvalidCredentialsError < BaseError
    MESSAGE = "INVALID_CREDENTIALS"
  end

  class ImageRequired < BaseError
    MESSAGE = "IMAGE_REQUIRED"
  end

  class ProductNotFound < BaseError
    MESSAGE = "PRODUCT_NOT_FOUND"
  end

  class UnauthorizedError < BaseError
    MESSAGE = "UNAUTHORIZED"
  end

  class UserIsNotOwner < BaseError
    MESSAGE = "USER_IS_NOT_OWNER"
  end
end
