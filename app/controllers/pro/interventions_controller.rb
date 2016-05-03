class Pro::InterventionsController < ApplicationController
  include Pro::AuthenticateConcern
  include Pro::AbilityConcern
  layout 'pro/application'

  before_filter :load_intervention, only: %i(show update)

  def index
    @q = current_pro.interventions.ransack params[:q]
    @interventions = @q.result.page(params[:page]).per(params[:per_page])
  end

  def show
    authorize! :read, @intervention
  end

  def update
    if intervention_params.key? :event
      if @intervention.send(intervention_params[:event] + '!')
        flash[:success] = 'Intervention mise à jour'
        redirect_to pro_intervention_path(@intervention)
      else
        flash[:error] = "Erreur lors de la mise à jour de l'intervention"
        render :show
      end
    else
      redirect_to pro_intervention_path(@intervention)
    end
  end

  private

  def intervention_params
    params.require(:intervention).permit(
      :event
    )
  end

  def load_intervention
    @intervention = Intervention.find(params[:id])
  end

end
