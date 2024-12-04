# frozen_string_literal: true

class EndSessionServiceJob
  include Sidekiq::Job

  def perform()
    Rails.logger.info 'EndSessionServiceJob Iniciado'

    session_service = SessionService.in_progress

    begin
      session_service.each do |session|
        session.update(status: :done) if session.end_at < Time.current.iso8601
      end
      Rails.logger.info 'EndSessionServiceJob Finalizado'
    rescue StandardError => e
      Rails.logger.error "EndSessionServiceJob falhou: #{e.message}"
      raise e
    end
  end
end
