class NotifyClientBySMSService
  include Rails.application.routes.url_helpers

  def initialize(interventions)
    @intervention = intervention
  end

  def perform
    #logger.info "NotifyClientBySMSJob.perform for intervention_id=#{intervention.id}"
    to = intervention.address.phone_number
    client_url = client_intervention_url(intervention, intervention_client_token_ownership: intervention.client_token_ownership, domain: Rails.application.secrets.host, host: Rails.application.secrets.host, subdomain: 'www')
    message = "Demande d'intervention acceptée, voir la fiche d'intervention: #{client_url}"
    NotifyBySMSJob.perform(to, message)
  end
end
