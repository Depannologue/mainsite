class AddInsurerIdToInterventions < ActiveRecord::Migration
  def change
    add_column :interventions, :insurer_id, :integer
  end
end
