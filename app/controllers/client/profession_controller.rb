class Client::ProfessionController < ApplicationController

  def show ()
    profession = Profession.find_by_name(params[:profession])
    @interventions = profession.InterventionType
  end

end
