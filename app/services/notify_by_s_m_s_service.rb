class NotifyBySMSService

      def perform(to, body)
          twilio_client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
          begin
            twilio_client.account.messages.create({
              from: Rails.application.secrets.twilio_from,
              to: "#{to}",
              body: "#{body}"
            })
          rescue Twilio::REST::RequestError => e
            puts e.message
          end
      end

end
