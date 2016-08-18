class ServiceProviderMailer < Devise::Mailer

  def new_service_provider_request(service_provider_informations)

    @service_provider_informations = service_provider_informations
    attachments[@service_provider_informations.file_kbis.original_filename] = File.read(@service_provider_informations.file_kbis.tempfile)
    attachments[@service_provider_informations.file_professional_insurance.original_filename] = File.read(@service_provider_informations.file_professional_insurance.tempfile)
    #attachments[@service_provider_informations.file_professional_insurance.original_filename] = File.read(@service_provider_informations.file_professional_insurance.tempfile)
    attachments[@service_provider_informations.file_iban.original_filename] = File.read(@service_provider_informations.file_iban.tempfile)
    mail to: "henri@depannologue.fr", subject: "Nouvelle demande depanneur :"
  end

  private

    def add_inline_attachment!
      attachments.inline["logo-blue.png"] = File.read(Rails.root.join("public", "logo-blue.png"))
    end
end
