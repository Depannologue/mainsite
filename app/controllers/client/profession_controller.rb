class Client::ProfessionController < ApplicationController

  def show
    @interventions = Profession.send(params[:profession])
  end

end
