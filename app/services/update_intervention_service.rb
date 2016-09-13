class UpdateInterventionService
  def self.perform(permitted_params, params)
    new.perform(permitted_params, params)
  end

  def perform(permitted_params, params)
    persist(permitted_params, params)
  end

  private

  def persist(permitted_params, params)
    intervention = Intervention.find_by_id(params[:id])
    intervention.contractors_declines.create(user_id: params[:intervention][:contractors_decline]) unless params[:intervention][:contractors_decline].blank?
    intervention.update_attributes permitted_params
    intervention
  end
end
