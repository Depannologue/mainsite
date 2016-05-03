class AddChargeIdToInterventions < ActiveRecord::Migration
  def change
    add_column :interventions, :charge_id, :string
  end
end
