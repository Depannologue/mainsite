class AddDescriptionToInterventionType < ActiveRecord::Migration
  def change
    add_column :intervention_types, :description, :string
  end
end
