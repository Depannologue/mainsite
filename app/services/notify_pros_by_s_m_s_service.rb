class NotifyProsBySMSService
  include Rails.application.routes.url_helpers
  def initialize(interventions)
    @intervention = intervention
  end

  def perform
    #logger.info "NotifyProsBySMSJob.perform for intervention_id=#{intervention.id}"
    pros_available = intervention.pros_now_available_and_nearby
    if pros_available
      pro_url = pro_intervention_step_url(intervention.id, id: :request_overview, domain: Rails.application.secrets.host, host: Rails.application.secrets.host, port: Rails.application.secrets.port, subdomain: 'pro')
      message = "Nouvelle demande d'intervention: #{pro_url}"
      pros_available.map(&:phone_number).each do |to|
        NotifyBySMSJob.perform(to, message)
      end
    end
  end
end
