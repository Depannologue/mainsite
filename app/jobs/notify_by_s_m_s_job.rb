class NotifyBySMSJob < ActiveJob::Base

  queue_as :default

  def self.perform(to, message)
    new.perform(to, message)
  end

  def perform(to, message)
    twilio_client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    twilio_client.account.messages.create({
      from: Rails.application.secrets.twilio_from,
      to: to,
      body: message
    })
  end
end
