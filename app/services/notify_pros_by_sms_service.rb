class NotifyProsBySmsService
  include Rails.application.routes.url_helpers

  def self.perform(intervention, pro)
    new.perform(intervention, pro)
  end

  def perform(intervention, pro)
    pro_url = pro_intervention_step_url(intervention.id, id: :request_overview, domain: Rails.application.secrets.host, host: Rails.application.secrets.host, port: Rails.application.secrets.port, subdomain: 'pro')
    intervention.immediate_intervention ?  date = 'immédiate' : date = intervention.intervention_date
    message = "Nouvelle demande d'intervention  #{date} : #{pro_url}"
    to = pro.phone_number
    NotifyBySmsJob.perform_later(to, message)
  end
end
