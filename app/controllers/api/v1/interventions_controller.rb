class Api::V1::InterventionsController < Api::V1::BaseController
  def index
    interventions = Api::V1::InterventionsFilter.new(Intervention.all, params).collection
    render  json:  interventions.map(&:restrict_for_api)
  end

  def show
    intervention = Intervention.find(params[:id]).restrict_for_api
    render  json: intervention.to_json
  end

  def create
    intervention = CreateInterventionServiceBis.perform(intervention_create_params)
    return api_error(status: 422, errors: intervention.errors) unless intervention.valid?
    render(
      json:     intervention.restrict_for_api,
      status:   201,
      location: api_v1_intervention_path(intervention.id)
    )
  end

  def update
    intervention = UpdateInterventionService.perform(intervention_update_params, params)
    return api_error(status: 422, errors: intervention.errors) unless intervention.save
    render(
      json:     intervention.restrict_for_api,
      status:   201,
      location: api_v1_intervention_path(intervention.id)
    )
  end

  private

  def intervention_update_params
    params.require(:intervention).permit(:state, :contractor_id, :price)
  end

  def intervention_create_params
    parameters = params.require(:intervention).permit(
      :state, :customer_id, :intervention_type_id, :immediate_intervention,
      address_attributes: [:city, :phone_number, :firstname, :lastname, :address1, :zipcode, :city]
    )

    intervention_time = DateTime.new(
                        params['intervention_date_attributes']['intervention_date_1i'].to_i,
                        params['intervention_date_attributes']['intervention_date_2i'].to_i,
                        params['intervention_date_attributes']['intervention_date_3i'].to_i,
                        params['intervention_date_attributes']['intervention_date_4i'].to_i,
                        params['intervention_date_attributes']['intervention_date_5i'].to_i,
                        params['intervention_date_attributes']['intervention_date_6i'].to_i).change(offset: '+0200')
    parameters = parameters.merge(intervention_date: intervention_time)
  end
end
