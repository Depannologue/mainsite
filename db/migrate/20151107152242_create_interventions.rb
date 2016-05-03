class CreateInterventions < ActiveRecord::Migration
  def change
    create_table :interventions do |t|
      t.string :kind
      t.string :state
      t.integer :customer_id, references: :users, index: true, foreign_key: true
      t.integer :contractor_id, references: :users, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
