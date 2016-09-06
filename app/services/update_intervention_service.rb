class UpdateInterventionService
  def self.perform(params, id)
    new.perform(params, id)
  end

  def perform(params, id)
    persist(params, id)
  end

  private

  def persist(params, id)
    intervention = Intervention.find_by_id(id)
    intervention.update(state: params[:state]) unless params[:state].blank?
    intervention.update(contractor_id: params[:contractor_id]) unless params[:contractor_id].blank?
    intervention.contractors_declines.create(user_id: params[:contractor_decline]) unless params[:contractor_decline].blank?
    intervention
  end
end
