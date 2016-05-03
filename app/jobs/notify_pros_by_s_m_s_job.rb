class NotifyProsBySMSJob < ActiveJob::Base
  queue_as :default
  include Rails.application.routes.url_helpers

  def perform(intervention_id)
    logger.info "NotifyProsBySMSJob.perform for intervention_id=#{intervention_id}"

    intervention = Intervention.find intervention_id
    pros_available = intervention.pros_now_available_and_nearby

    if pros_available
      twilio_client = Twilio::REST::Client.new Figaro.env.TWILIO_ACCOUNT_SID, Figaro.env.TWILIO_AUTH_TOKEN
      pro_url = pro_intervention_step_url(intervention.id, id: :request_overview, domain: Figaro.env.HOST, host: Figaro.env.HOST, port: Figaro.env.PORT, subdomain: 'pro')

      pros_available.map(&:phone_number).each do |phone_number|
        begin
          twilio_client.account.messages.create({
            from: Figaro.env.TWILIO_FROM,
            to: phone_number,
            body: "Nouvelle demande d'intervention: #{pro_url}"
          })
        rescue Twilio::REST::RequestError => e
          puts e.message
        end
      end
    end
    
  end
end
