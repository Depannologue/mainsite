class AddPriceToInterventions < ActiveRecord::Migration
  def change
    add_column :interventions, :price, :decimal
  end
end
