class AddSlugToInterventionTypes < ActiveRecord::Migration
  def change
    add_column :intervention_types, :slug, :string
  end
end
