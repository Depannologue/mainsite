class CreateHistoricalTransitions < ActiveRecord::Migration
  def change
    create_table :historical_transitions do |t|
      t.integer :historisable_id, index: true
      t.string  :historisable_type
      t.string :event
      t.string :from
      t.string :to
      t.datetime :processed_at

      t.timestamps
    end
  end
end
