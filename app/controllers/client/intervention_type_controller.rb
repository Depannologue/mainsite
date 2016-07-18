class Client::InterventionTypeController < ApplicationController
  def show
    intervention_parent_id = InterventionType.find_by_slug(params[:intervention_parent_slug]).id
    @intervention_childs = InterventionType.where(parent_id: intervention_parent_id)
    render 'intervention_type'
  end



end
