class RemovePayements < ActiveRecord::Migration
  def up
    remove_column :interventions, :charge_id
    remove_column :interventions, :payment_validated_at
    remove_column :intervention_types, :down_payment

    add_column :interventions, :payment_method, :string

    Intervention.all.each do |intervention|
      intervention.update(payment_method: :credit_card)
    end
  end

  def down
    add_column :interventions, :charge_id, :string
    add_column :interventions, :payment_validated_at, :datetime
    add_column :intervention_types, :down_payment, :decimal

    remove_column :interventions, :payment_method, :string
  end
end
