class RemoveKindFromInterventionType < ActiveRecord::Migration
  def change
    remove_column :intervention_types, :kind, :string
  end
end
