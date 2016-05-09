class NotifyBookingOkBySMSJob < ActiveJob::Base
  queue_as :default
  include Rails.application.routes.url_helpers

  def perform(intervention_id)
    logger.info "NotifyBookingOkBySMSJob.perform for intervention_id=#{intervention_id}"
    intervention = Intervention.find intervention_id
    client = intervention.customer

    twilio_client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    begin
      twilio_client.account.messages.create({
        from: Rails.application.secrets.twilio_from,
        to: client.phone_number,
        body: "Votre demande d'intervention a bien été prise en compte et est en cours de traitement."
      })
    rescue Twilio::REST::RequestError => e
      puts e.message
    end
  end
end
