class AddInterventionDateToInterventions < ActiveRecord::Migration
  def change
    add_column :interventions, :intervention_date, :datetime
  end
end
