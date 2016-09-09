class Admin::DashboardController < ApplicationController
  include Admin::AuthenticateConcern
  include Admin::AbilityConcern
  layout 'admin/application'


  def index
    interventions = Intervention.all

    @revenues = 0
    interventions.each do |intervention|
      @revenues += intervention.price
    end
    @professions_revenues = professions_revenues

  end

  private

  def professions_revenues
    professions = Profession.all
    revenues_by_professions = Array.new
    professions.each do |profession|
      profession_revenues = profession.interventions.sum(:price)
      revenues_by_professions.push([profession.name,profession_revenues])
    end
    revenues_by_professions
  end



end
