class Admin::InterventionPresenter
  def today_s_number_of_interventions
    Intervention.today.count
  end

  def today_s_revenues
    Intervention.today.sum(:price)
  end

  def month_s_number_of_interventions
    Intervention.where(created_at: Time.now.beginning_of_month..Time.now.end_of_day).count
  end

  def month_s_revenues
    Intervention.where(created_at: Time.now.beginning_of_month..Time.now.end_of_day).sum(:price)
  end

  def total_number_of_interventions
    Intervention.count
  end

  def total_revenues
    Intervention.sum(:price)
  end

  def total_average_per_intervention
    total_number_of_interventions > 1 ? total_revenues/total_number_of_interventions : total_revenues
  end
end
