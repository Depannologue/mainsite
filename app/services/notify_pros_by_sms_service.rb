class NotifyProsBySmsService
  include Rails.application.routes.url_helpers

  def self.perform(intervention, pros)
    new.perform(intervention, pros)
  end

  def perform(intervention, pros)
    pros_available = pros
    if pros_available
      pro_url = pro_intervention_step_url(intervention.id, id: :request_overview, domain: Rails.application.secrets.host, host: Rails.application.secrets.host, port: Rails.application.secrets.port, subdomain: 'pro')
      message = "Nouvelle demande d'intervention: #{pro_url}"
      pros_available.map(&:phone_number).each do |to|
        NotifyBySmsJob.perform_later(to, message)
      end
    end
  end
end
