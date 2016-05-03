class ClientMailer < Devise::Mailer
  layout 'client/mailer'

  before_filter :add_inline_attachment!

  def invitation_instructions(record, token, opts={})
    @customer = record
    @token = token
    mail to: @customer.email, subject: "Confirmez votre compte"
  end

  def confirm_payment(intervention)
    @intervention = intervention
    @customer = @intervention.customer

    mail to: @customer.email, subject: "Votre paiement à été accepté"
  end

  def confirm_booking(intervention)
    @intervention = intervention
    @customer = ClientDecorator.new @intervention.customer

    mail to: @customer.email, subject: "Votre réservation a été enregistrée"
  end

  def notify_a_pro_will_happen(intervention)
    @intervention = intervention
    @customer = ClientDecorator.new @intervention.customer
    @contractor = ProDecorator.new @intervention.contractor

    mail to: @customer.email, subject: "Votre dépanneur #{@contractor.firstname.capitalize} est en route."
  end

  private

    def add_inline_attachment!
      attachments.inline["logo-blue.png"] = File.read(Rails.root.join("public", "logo-blue.png"))
    end
end
