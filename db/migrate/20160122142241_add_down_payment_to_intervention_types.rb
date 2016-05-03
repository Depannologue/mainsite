class AddDownPaymentToInterventionTypes < ActiveRecord::Migration
  def change
    add_column :intervention_types, :down_payment, :decimal
  end
end
