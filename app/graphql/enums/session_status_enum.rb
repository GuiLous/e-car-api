# frozen_string_literal: true

module Enums
  class SessionStatusEnum < Types::BaseEnum
    value "created", "Created"
    value "in_progress", "In Progress"
    value "done", "Done"
  end
end