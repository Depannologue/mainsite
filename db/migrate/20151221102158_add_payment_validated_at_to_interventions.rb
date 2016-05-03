class AddPaymentValidatedAtToInterventions < ActiveRecord::Migration
  def change
    add_column :interventions, :payment_validated_at, :datetime
  end
end
