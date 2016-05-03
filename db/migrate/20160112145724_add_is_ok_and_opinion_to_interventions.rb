class AddIsOkAndOpinionToInterventions < ActiveRecord::Migration
  def change
    add_column :interventions, :is_ok, :boolean
    add_column :interventions, :opinion, :text
  end
end
