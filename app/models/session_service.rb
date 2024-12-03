class SessionService < ApplicationRecord
  enum :status, { created: 0, in_progress: 1, done: 2 }
  has_many :hired_service
end
