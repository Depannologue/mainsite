class NotifyBookingOkBySMSService
  include Rails.application.routes.url_helpers

  def initialize(interventions)
    @intervention = intervention
  end

  def perform
    #logger.info "NotifyBookingOkBySMSJob.perform for intervention_id=#{intervention.id}"
    client = intervention.customer
    to = client.phone_number
    message = "Votre demande d'intervention a bien été prise en compte et est en cours de traitement."
    NotifyBySMSJob.perform(to, message)
  end
end
