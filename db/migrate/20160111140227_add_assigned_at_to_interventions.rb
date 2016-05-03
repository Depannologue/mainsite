class AddAssignedAtToInterventions < ActiveRecord::Migration
  def change
    add_column :interventions, :assigned_at, :datetime
  end
end
