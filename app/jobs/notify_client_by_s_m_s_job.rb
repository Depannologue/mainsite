class NotifyClientBySMSJob < ActiveJob::Base
  queue_as :default
  include Rails.application.routes.url_helpers

  def perform(intervention_id)
    logger.info "NotifyClientBySMSJob.perform for intervention_id=#{intervention_id}"
    intervention = Intervention.find intervention_id
    to_phone_number = intervention.address.phone_number

    twilio_client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    client_url = client_intervention_url(intervention, intervention_client_token_ownership: intervention.client_token_ownership, domain: Rails.application.secrets.host, host: Rails.application.secrets.host, subdomain: 'www')
    begin
      twilio_client.account.messages.create({
        from: Rails.application.secrets.twilio_from,
        to: to_phone_number,
        body: "Demande d'intervention acceptée, voir la fiche d'intervention: #{client_url}"
      })
    rescue Twilio::REST::RequestError => e
      puts e.message
    end
  end
end
