class ServiceProviderMailer < Devise::Mailer

  def new_service_provider_request(service_provider_informations)

    @service_provider_informations = service_provider_informations
    (attachments[@service_provider_informations.file_kbis.original_filename] = File.read(@service_provider_informations.file_kbis.tempfile)) unless @service_provider_informations.file_kbis.nil?
    (attachments[@service_provider_informations.file_professional_insurance.original_filename] = File.read(@service_provider_informations.file_professional_insurance.tempfile)) unless @service_provider_informations.file_professional_insurance.nil?
    (attachments[@service_provider_informations.file_iban.original_filename] = File.read(@service_provider_informations.file_iban.tempfile)) unless @service_provider_informations.file_iban.nil?
    mail to: "Henri@depannologue.fr", subject: "Demande depanneur : "+@service_provider_informations.firstname+" "+@service_provider_informations.lastname
  end

  private
    def add_inline_attachment!
      attachments.inline["logo-blue.png"] = File.read(Rails.root.join("public", "logo-blue.png"))
    end
end
