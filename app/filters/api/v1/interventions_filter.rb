class Api::V1::InterventionsFilter < Api::V1::BaseFilter

  def collection
    interventions = self.resource

    unless params[:start_date].blank?
      interventions = interventions.where('interventions.created_at >= ?', params[:start_date])
    end

    unless params[:end_date].blank?
      interventions = interventions.where('interventions.created_at <= ?', params[:end_date])
    end
    unless params[:is_in_state].blank?
      interventions = interventions.where('interventions.state = ?', params[:is_in_state])
    end

    unless params[:is_not_in_state].blank?
      interventions = interventions.where('interventions.state != ?', params[:is_not_in_state])
    end

    unless params[:contractor_id].blank?
        interventions = interventions.where('interventions.contractor_id = ?', params[:contractor_id].to_i)
    end

    unless params[:current_month].blank?
        interventions = interventions.where('interventions.created_at >=   ? AND interventions.created_at <=  ? ', Date.today.strftime("%Y%m01"),  Date.today.strftime("%Y%m30") )
    end

    unless params[:contractor_decline].blank?
      interventions = interventions.where.not(:id => ContractorsDecline.select(:intervention_id).where(user_id: params[:contractor_decline].to_i))
    end
   return self.with_associations(interventions)
  end
end
