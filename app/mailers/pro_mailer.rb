class ProMailer < ActionMailer::Base
  layout 'pro/mailer'

  before_filter :add_inline_attachment!

  def notify_intervention_created(pro, intervention)
    @pro = pro
    @intervention = intervention

    mail to: @pro.email, subject: "Nouvelle intervention à proximité"
  end

  private

    def add_inline_attachment!
      attachments.inline["logo-blue.png"] = File.read(Rails.root.join("public", "logo-blue.png"))
    end
end
