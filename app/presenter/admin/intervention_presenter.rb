class Admin::InterventionPresenter
  def today_s_number_of_interventions
    Intervention.today.count
  end

  def initialize(interventions)
      @interventions = interventions
  end

  def today_s_revenues
    @interventions.today.sum(:price)
  end

  def month_s_number_of_interventions
    @interventions.month.count
  end

  def month_s_revenues
    @interventions.month.sum(:price)
  end

  def total_number_of_interventions
    @interventions.count
   end

  def total_revenues
    @interventions.sum(:price)
  end

  def total_average_per_intervention
    total_number_of_interventions > 1 ? total_revenues/total_number_of_interventions : total_revenues
  end
end
