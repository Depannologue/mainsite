class Api::V1::InterventionsController < Api::V1::BaseController

  def index
    interventions = Api::V1::InterventionsFilter.new(Intervention.all, params).collection
    render  json:  array_serializer(interventions)
  end

  def show
    intervention = Intervention.find(params[:id]).restrict_for_api
    render(json: intervention.to_json)
  end

  def create
    user_informations_form = UserInformationsForm.new(user_informations_form_params)
    return api_error(status: 422, errors: user_informations_form.errors) unless user_informations_form.save
    intervention_type = InterventionType.find_by_id(params[:intervention][:intervention_type_id])
    intervention = CreateInterventionService.perform(user_informations_form.address, user_informations_form.customer, intervention_type, intervention_type.profession_id,user_informations_form.is_immediate,user_informations_form.date_intervention)
    return api_error(status: 422, errors: intervention.errors) unless intervention.valid?
    render(
      json:intervention.restrict_for_api,
      status: 201,
      location: api_v1_intervention_path(intervention.id)
    )
  end

  def update
    intervention = UpdateInterventionService.perform(params[:intervention], params[:id])
    return api_error(status: 422, errors: intervention.errors) unless intervention.save
    render(
      json:intervention.restrict_for_api,
      status: 201,
      location: api_v1_intervention_path(intervention.id)
    )
  end
  private

  def user_informations_form_params
    parameters = params.require(:intervention).permit(:firstname, :lastname, :address1, :address2, :zipcode, :phone_number, :city, :email, :intervention_date, :immediate_intervention,:intervention_date_1i, :intervention_date_2i, :intervention_date_3i, :intervention_date_4i, :intervention_date_5i, :intervention_date_6i)
    intervention_time = DateTime.new(parameters["intervention_date_1i"].to_i, parameters["intervention_date_2i"].to_i, parameters["intervention_date_3i"].to_i,parameters["intervention_date_4i"].to_i, parameters["intervention_date_5i"].to_i, parameters["intervention_date_6i"].to_i).change(:offset => "+0200")
    parameters = parameters.merge(intervention_date: intervention_time)
  end

  def array_serializer interventions
      interventions_serialized = Array.new
      interventions.each do |intervention|
        interventions_serialized.push(intervention.restrict_for_api)
      end
      interventions_serialized
  end

end
