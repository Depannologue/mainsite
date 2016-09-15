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
    @interventions_among_time=interventions_among_time
    @today_s_number_of_interventions=today_s_number_of_interventions
    @today_s_revenues=today_s_revenues
    @month_s_number_of_interventions=month_s_number_of_interventions
    @month_s_revenues=month_s_revenues
    #raise @interventions_among_time.inspect

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

  def interventions_among_time
    from = DateTime.new(2001,2,3);
    to = Time.now
    interventions_array = Array.new
    interventions = Intervention.group('date(created_at)').where(created_at: from .. to).count
    interventions.each do |intervention|
      interventions_array.push([intervention[0].strftime("%Y/%m/%d/"),intervention[1]])
    end
    interventions_array
  end

  def today_s_number_of_interventions
    Intervention.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day).count
  end

  def today_s_revenues
    Intervention.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day).sum(:price)
  end

  def month_s_number_of_interventions
    Intervention.where(created_at: Time.now.beginning_of_month..Time.now.end_of_day).count
  end

  def month_s_revenues
    Intervention.where(created_at: Time.now.beginning_of_month..Time.now.end_of_day).sum(:price)
  end
end
