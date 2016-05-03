class Admin::InterventionTypesController < ApplicationController
  include Admin::AuthenticateConcern
  include Admin::AbilityConcern
  layout 'admin/application'

  before_filter :load_intervention_type, only: %i(show edit update destroy)

  def index
    @intervention_types = InterventionType.all.page(params[:page])
  end

  def new
    @intervention_type = InterventionType.new
  end

  def create
    @intervention_type = InterventionType.new(permitted_params)
    if @intervention_type.save
      flash[:success] = "Type d'intervention créé"
      redirect_to admin_intervention_types_path
    else
      flash[:error] = "Erreur lors de la création du type d'intervention"
      render :new
    end
  end

  def edit
  end

  def update
    if @intervention_type.update_attributes permitted_params
      flash[:success] = "Type d'intervention mise à jour"
      redirect_to admin_intervention_types_path
    else
      flash[:error] = "Erreur lors de la mise à jour du type d'intervention"
      render :edit
    end
  end

  def destroy
    @intervention_type.destroy
    flash[:success] = "Type d'intervention supprimé"
    redirect_to admin_intervention_types_path
  end

  private

  def load_intervention_type
    @intervention_type = InterventionType.find(params[:id])
  end

  def permitted_params
    params.require(:intervention_type).permit(
      :kind,
      :short_description,
      :description,
      :price
    )
  end
end
