class AddTokenOwnershipToInterventions < ActiveRecord::Migration
  def change
    add_column :interventions, :client_token_ownership, :string
    add_index :interventions, :client_token_ownership, unique: true
  end
end
