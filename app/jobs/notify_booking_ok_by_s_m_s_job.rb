class NotifyBookingOkBySMSJob < ActiveJob::Base
  queue_as :default
  include Rails.application.routes.url_helpers

  def perform(intervention_id)
    logger.info "NotifyBookingOkBySMSJob.perform for intervention_id=#{intervention_id}"
    intervention = Intervention.find intervention_id
    client = intervention.customer

    phone_number = client.phone_number

    body = "Votre demande d'intervention a bien été prise en compte et est en cours de traitement."
    NotifyBySMSService.new.perform(phone_number, body)

  end
end
