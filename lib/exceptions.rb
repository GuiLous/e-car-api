# frozen_string_literal: true

module Exceptions
  class SameUserError < StandardError
    def initialize(msg = "SAME_USER_ERROR")
      super
    end
  end

  class InsufficientCoinsError < StandardError
    def initialize(msg = "INSUFFICIENT_COINS")
      super
    end
  end
end