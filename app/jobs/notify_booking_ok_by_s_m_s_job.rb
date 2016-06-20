class NotifyBookingOkBySMSJob < ActiveJob::Base
  queue_as :default
  include Rails.application.routes.url_helpers

  def perform(intervention)
    logger.info "NotifyBookingOkBySMSJob.perform for intervention_id=#{intervention.id}"
    client = intervention.customer
    phone_number = client.phone_number
    message = "Votre demande d'intervention a bien été prise en compte et est en cours de traitement."
    NotifyBySMSService.perform(phone_number, message)
  end
end
