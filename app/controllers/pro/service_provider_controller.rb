class Pro::ServiceProviderController < ApplicationController
  def show

  end

  def new
    @service_provider_informations_form = ServiceProviderInformationsForm.new
  end

  def create
    @service_provider_informations_form = ServiceProviderInformationsForm.new(service_provider_informations_form_params)
    if @service_provider_informations_form.save
      ServiceProviderMailer.new_service_provider_request(@service_provider_informations_form).deliver
    else
      render :new
    end
  end

  def service_provider_informations_form_params
    parameters = params.require(:service_provider_informations_form).permit(:firstname,:lastname,:email,:phone_number,:is_a_plumber,:is_a_locksmith,:is_a_glazier,:status,:number_of_employees,:file_kbis,:file_professional_insurance,:file_iban,:has_a_smartphone,:society,:siret,:siege_address,:is_an_electrician,:is_a_drywall_worker,:is_a_painter,:is_a_ground_setter,:is_a_heating_engineer,:have_read_partnership_general_conditions,:accepted_partnership_general_conditions)
  end

end
