class Pro::InterventionStepsController < ApplicationController
  include Pro::AuthenticateConcern
  include Pro::AbilityConcern
  include Wicked::Wizard
  layout 'pro/application'

  before_filter :load_intervention

  steps :request_overview

  def show
    if can? :read, @intervention
      case step
      when :request_overview
        jump_to next_step if cannot? :set_contractor, @intervention
      end
      render_wizard
    else
      flash[:error] = "Il n'est plus nécessaire de trouver un dépanneur pour cette intervention."
      redirect_to pro_root_path
    end
  end

  def update
    case step
    when :request_overview
      authorize! :set_contractor, @intervention
      if @intervention.assign_to! current_pro
        jump_to next_step
      end
    end
    render_wizard
  end

  def finish_wizard_path
    pro_intervention_path id: @intervention.id
  end

  private

  def load_intervention
    @intervention = Intervention.find(params[:intervention_id])
  end

  def permitted_params
    params.require(:intervention).permit(
      :contractor_id
    )
  end
end
