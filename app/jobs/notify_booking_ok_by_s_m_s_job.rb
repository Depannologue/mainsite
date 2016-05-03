class NotifyBookingOkBySMSJob < ActiveJob::Base
  queue_as :default
  include Rails.application.routes.url_helpers

  def perform(intervention_id)
    logger.info "NotifyBookingOkBySMSJob.perform for intervention_id=#{intervention_id}"
    intervention = Intervention.find intervention_id
    client = intervention.customer

    twilio_client = Twilio::REST::Client.new Figaro.env.TWILIO_ACCOUNT_SID, Figaro.env.TWILIO_AUTH_TOKEN
    begin
      twilio_client.account.messages.create({
        from: Figaro.env.TWILIO_FROM,
        to: client.phone_number,
        body: "Votre demande d'intervention a bien été prise en compte et est en cours de traitement."
      })
    rescue Twilio::REST::RequestError => e
      puts e.message
    end
  end
end
