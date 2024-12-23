# frozen_string_literal: true

module Authenticatable
  extend ActiveSupport::Concern

  def authenticate_user!
    raise Exceptions::UnauthorizedError unless context[:current_user]
  end
end
