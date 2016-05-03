class AdminMailer < ActionMailer::Base
  layout 'admin/mailer'

  before_filter :add_inline_attachment!

  def none_available_pro(intervention)
    @intervention = intervention
    @admin = User.admins.first

    mail to: @admin.email, subject: "Aucun professionnel n'est disponible"
  end

  private

    def add_inline_attachment!
      attachments.inline["logo-blue.png"] = File.read(Rails.root.join("public", "logo-blue.png"))
    end
end
