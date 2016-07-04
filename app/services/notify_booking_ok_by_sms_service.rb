class NotifyBookingOkBySmsService
  include Rails.application.routes.url_helpers

  def self.perform(intervention)
    new.perform(intervention)
  end

  def perform(intervention)
    client = intervention.customer
    to = client.phone_number
    message = "Votre demande d'intervention a bien été prise en compte et est en cours de traitement."
    NotifyBySmsJob.perform_later(to, message)
  end
end
