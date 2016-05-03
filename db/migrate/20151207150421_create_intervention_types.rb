class CreateInterventionTypes < ActiveRecord::Migration
  def change
    create_table :intervention_types do |t|
      t.string :kind
      t.string :short_description
      t.decimal :price

      t.timestamps null: false
    end

    add_column :interventions, :intervention_type_id, :integer
    add_index :interventions, :intervention_type_id
    remove_column :interventions, :kind, :string
  end
end
