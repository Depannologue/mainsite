class NotifyClientBySMSJob < ActiveJob::Base
  queue_as :default
  include Rails.application.routes.url_helpers

  def perform(intervention_id)
    logger.info "NotifyClientBySMSJob.perform for intervention_id=#{intervention_id}"
    intervention = Intervention.find intervention_id
    to_phone_number = intervention.address.phone_number


    client_url = client_intervention_url(intervention, intervention_client_token_ownership: intervention.client_token_ownership, domain: Rails.application.secrets.host, host: Rails.application.secrets.host, subdomain: 'www')
    body = "Demande d'intervention acceptée, voir la fiche d'intervention: #{client_url}"

    NotifyBySMSService.new.perform(to_phone_number, body)


  end
end
