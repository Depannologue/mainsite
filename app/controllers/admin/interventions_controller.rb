class Admin::InterventionsController < ApplicationController
  include Admin::AuthenticateConcern
  include Admin::AbilityConcern
  layout 'admin/application'

  before_filter :load_intervention, only: %i(edit update destroy)

  def index
    @q = Intervention.ransack params[:q]
    @q.sorts = 'created_at desc' if @q.sorts.empty?
    @interventions = @q.result.page(params[:page]).per(params[:per_page])
  end

  def edit
  end

  def update
    if (intervention_params.key? :contractor_id) &&
       (@intervention.contractor_id != intervention_params[:contractor_id].to_i)
      @intervention.unassign if @intervention.may_unassign?
      if intervention_params[:contractor_id].present?
        pro = User.find intervention_params[:contractor_id]
        @intervention.assign_to! pro
      end
    end
    if intervention_params.key? :event
      @intervention.send (intervention_params[:event] + '!')
    end
    if @intervention.update_attributes intervention_params.except(:contractor_id, :event)
      flash[:success] = 'Intervention mise à jour'
      redirect_to admin_interventions_path
    else
      flash[:error] = "Erreur lors de la mise à jour de l'intervention"
      render :edit
    end
  end

  def destroy
    @intervention.destroy
    flash[:success] = 'Intervention supprimée'
    redirect_to admin_interventions_path
  end

  private

  def intervention_params
    params.require(:intervention).permit(
      :intervention_type_id,
      :contractor_id,
      :event,
      :is_ok,
      :rating,
      :opinion,
      address_attributes: [
        :firstname,
        :lastname,
        :address1,
        :address2,
        :zipcode,
        :city,
        :phone_number,
        :id
      ]
    )
  end

  def load_intervention
    @intervention = Intervention.find(params[:id])
  end
end
