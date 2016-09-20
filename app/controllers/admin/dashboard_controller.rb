class Admin::DashboardController < ApplicationController
  include Admin::AuthenticateConcern
  include Admin::AbilityConcern
  layout 'admin/application'

  def index
    @dashboard_presenter = Admin::InterventionPresenter.new
    interventions = Intervention.all
    @professions_revenues = professions_revenues
    @interventions_among_time = interventions_among_time
  end

  private

  def professions_revenues
    professions = Profession.all
    revenues_by_professions = {}
    revenues_by_professions = professions.map {|profession| {name:profession.name,
                                    nb_interventions:profession.interventions.count,
                                    revenues:profession.interventions.sum(:price),
                                    average_revenue:profession.interventions.count > 1 ? profession.interventions.sum(:price)/profession.interventions.count : profession.interventions.sum(:price)}}
  end

  def interventions_among_time
    dates_with_count = {}
    (Date.today - 4.month..Date.today).each { |date| dates_with_count[date] = 0 }
    Intervention.pluck(:created_at).each { |intervention_date| dates_with_count[intervention_date.to_date] += 1 }
    dates_with_count.map { |date, count| {date: date, value: count }}
  end

end
