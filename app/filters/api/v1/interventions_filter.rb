class Api::V1::InterventionsFilter < Api::V1::BaseFilter

  def collection
    interventions = self.resource
    unless params[:start_date].blank?
      interventions = interventions.where('interventions.created_at >= ?', params[:start_date])
    end

    unless params[:end_date].blank?
      interventions = interventions.where('interventions.created_at <= ?', params[:end_date])
    end

   return self.with_associations(interventions)
  end
end
