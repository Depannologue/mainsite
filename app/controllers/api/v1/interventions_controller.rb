class Api::V1::InterventionsController < Api::V1::BaseController
  include ActiveHashRelation

  def index
    interventions = Intervention.all
    interventions = apply_filters(interventions, params)
    render(
      json: ActiveModel::ArraySerializer.new(
        interventions,
        each_serializer: Api::V1::InterventionSerializer,
        root: 'interventions',
      )
    )
  end

  def show
    intervention = Intervention.find(params[:id])
    render(json: Api::V1::InterventionSerializer.new(intervention).to_json)
  end

  def create
    user_informations_form = UserInformationsForm.new(user_informations_form_params)
    return api_error(status: 422, errors: user_informations_form.errors) unless user_informations_form.save

    intervention_type = InterventionType.find_by_slug(params[:intervention][:intervention_child_slug])
    intervention = CreateInterventionService.perform(user_informations_form.address, user_informations_form.customer, intervention_type, params[:intervention][:profession_id],user_informations_form.is_immediate,user_informations_form.date_intervention)
    return api_error(status: 422, errors: intervention.errors) unless intervention.valid?
    render(
      json: Api::V1::InterventionSerializer.new(intervention).to_json,
      status: 201,
      location: api_v1_intervention_path(intervention.id)
    )
  end

  private

  def user_informations_form_params
    parameters = params.require(:intervention).permit(:firstname, :lastname, :address1, :address2, :zipcode, :phone_number, :city, :email, :intervention_date, :immediate_intervention)
    intervention_time = DateTime.new(parameters["intervention_date(1i)"].to_i, parameters["intervention_date(2i)"].to_i, parameters["intervention_date(3i)"].to_i,parameters["intervention_date(4i)"].to_i, parameters["intervention_date(5i)"].to_i, parameters["intervention_date(6i)"].to_i).change(:offset => "+0200")
    parameters = parameters.merge(intervention_date: intervention_time)
  end

end
