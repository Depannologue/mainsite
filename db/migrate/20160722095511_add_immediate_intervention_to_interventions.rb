class AddImmediateInterventionToInterventions < ActiveRecord::Migration
  def change
    add_column :interventions, :immediate_intervention, :boolean
  end
end
