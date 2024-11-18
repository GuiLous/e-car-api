# frozen_string_literal: true

class AssistantSubmission < ApplicationRecord
  belongs_to :user

  enum :status, { pending: 1, approved: 2, rejected: 3 }
end
