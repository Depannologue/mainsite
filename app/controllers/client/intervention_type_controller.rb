class Client::InterventionTypeController < ApplicationController
  def show
    intervention_parent_id = InterventionType.where(slug: params[:intervention_parent])
    @intervention_childs = InterventionType.where(parent_id: intervention_parent_id)
    render 'intervention_type'
  end
end
