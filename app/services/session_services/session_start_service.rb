# frozen_string_literal: true

module SessionServices
  class SessionStartService
    include Singleton

    def start(hired_service_id:, current_user:)
      hired_service = HiredService.find(hired_service_id)
      raise Exceptions::HiredServiceItsNotLive unless hired_service.assistant_service.live?

      session_service = hired_service.session_service
      session_service = consumer_start_session(hired_service, session_service) if current_user.customer?

      raise Exceptions::SessionServiceNotFound if session_service.nil?
      raise Exceptions::SessionServiceInProgress if session_service.in_progress?

      assistant_start_session(session_service) if current_user.assistant?

      session_service
    end

    private

    def assistant_start_session(session_service)
      return session_service if session_service.assistant_started_at.present?

      session_service.update(assistant_started_at: DateTime.current, status: :in_progress, end_at: DateTime.current + 1.minutes)
    end

    def consumer_start_session(hired_service, session_service)
      session_service = SessionService.create!(hired_service: hired_service, status: :created) if session_service.nil?
      return session_service if session_service.consumer_started_at.present?

      session_service.update(consumer_started_at: DateTime.current)
      session_service
    end
  end
end
