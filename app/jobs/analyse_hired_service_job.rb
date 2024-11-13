# frozen_string_literal: true

class AnalyseHiredServiceJob
  include Sidekiq::Job

  def perform()
    Rails.logger.info 'AnalyseHiredServiceJob Iniciado'

    hired_services = HiredService.analysis_finished

    begin
      hired_services.each do |hired_service|
        HiredServices::UpdateToDoneService.instance.update_to_done(hired_service_id: hired_service.id)
      end

      Rails.logger.info 'AnalyseHiredServiceJob Finalizado'
    rescue StandardError => e
      Rails.logger.error "AnalyseHiredServiceJob falhou: #{e.message}"
      raise e
    end
  end
end