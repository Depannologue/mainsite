class Admin::ProfessionsController < ApplicationController
  include Admin::AuthenticateConcern
  include Admin::AbilityConcern
  layout 'admin/application'

  before_filter :load_profession, only: %i(edit update destroy)

  def index
    @professions = Profession.page(params[:page])
  end

  def new
    @profession = Profession.new
  end

  def create
    @profession = Profession.new(profession_params)
    if @profession.save
      flash[:success] = "Profession créée"
      redirect_to admin_professions_path
    else
      raise @profession.inspect
      flash[:error] = "Erreur lors de la création de la profession"
      render :new
    end
  end

  def destroy
    InterventionType.where(profession_id: @profession.id).delete_all
    @profession.delete

    flash[:success] = "profession supprimée"
    redirect_to admin_professions_path
  end

  def edit
    def update
      if @profession.update_attributes profession_params
        flash[:success] = "Profession mise à jour"
        redirect_to admin_professions_path
      else
        flash[:error] = "Erreur lors de la mise à jour de la profession"
        render :edit
      end
    end
  end

  def update

  end

  private

  def profession_params
    params.require(:profession).permit(
      :id,
      :name,
      :slug
    )
  end

  def load_profession
    @profession = Profession.find(params[:id])
  end
end
