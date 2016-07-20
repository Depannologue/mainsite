class AddProfessionToInterventionType < ActiveRecord::Migration
  def change
    add_column :intervention_types, :profession_id, :integer
  end
end
