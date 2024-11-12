# frozen_string_literal: true

module Exceptions
  class SameUserError < StandardError
    def initialize(msg = "SAME_USER_ERROR")
      super
    end
  end
end