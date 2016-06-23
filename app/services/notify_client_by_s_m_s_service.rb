class NotifyClientBySMSService
  include Rails.application.routes.url_helpers
  require 'notify_by_s_m_s_job'
  def self.perform(intervention)
    new.perform(intervention)
  end

  def perform(service)
    #logger.info "NotifyClientBySMSJob.perform for intervention_id=#{intervention.id}"
    to = intervention.address.phone_number
    client_url = client_intervention_url(intervention, intervention_client_token_ownership: intervention.client_token_ownership, domain: Rails.application.secrets.host, host: Rails.application.secrets.host, subdomain: 'www')
    message = "Demande d'intervention acceptée, voir la fiche d'intervention: #{client_url}"
    NotifyBySMSJob.perform(to, message)
  end
end
