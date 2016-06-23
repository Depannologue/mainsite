class NotifyBookingOkBySMSService
  include Rails.application.routes.url_helpers
  require 'notify_by_s_m_s_job'
  def self.perform(intervention)
    new.perform(intervention)
  end

  def perform(intervention)
    #logger.info "NotifyBookingOkBySMSJob.perform for intervention_id=#{intervention.id}"
    client = intervention.customer
    to = client.phone_number
    message = "Votre demande d'intervention a bien été prise en compte et est en cours de traitement."
    NotifyBySMSJob.perform(to, message)
  end
end
