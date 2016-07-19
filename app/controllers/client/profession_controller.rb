class Client::ProfessionController < ApplicationController
  def show
    profession = Profession.find_by_slug!(params[:profession])
    @intervention_parents = profession.intervention_type.where(parent_id: nil)
  end


end
