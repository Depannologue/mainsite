class Admin::DashboardController < ApplicationController
  include Admin::AuthenticateConcern
  include Admin::AbilityConcern
  layout 'admin/application'


  def index
    interventions = Intervention.all

    @total_number_of_interventions = interventions.count
    @total_revenues = interventions.sum(:price)
    @total_average_per_intervention = @total_number_of_interventions > 1 ? @total_revenues/@total_number_of_interventions : @total_revenues
    @professions_revenues = professions_revenues

  end

  private

  def professions_revenues
    professions = Profession.all
    revenues_by_professions = Array.new
    professions.each do |profession|
      profession_number_of_interventions = profession.interventions.count
      profession_revenues = profession.interventions.sum(:price)
      profession_average_per_intervention =  profession_number_of_interventions > 1 ? profession_revenues/profession_number_of_interventions : profession_revenues
      revenues_by_professions.push([profession.name,profession_number_of_interventions,profession_revenues,profession_average_per_intervention])
    end
    revenues_by_professions
  end



end
