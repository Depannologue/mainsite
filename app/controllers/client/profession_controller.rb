class Client::ProfessionController < ApplicationController
  def show
    session[:profession_id] = params[:profession]
    @profession = Profession.find_by_slug!(params[:profession])
    @intervention_parents = @profession.intervention_types.where(parent_id: nil)
  end
end
