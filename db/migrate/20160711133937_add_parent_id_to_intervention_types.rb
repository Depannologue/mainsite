class AddParentIdToInterventionTypes < ActiveRecord::Migration
  def change
    add_column :intervention_types, :parent_id, :integer
  end
end
