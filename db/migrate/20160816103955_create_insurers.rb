class CreateInsurers < ActiveRecord::Migration
  def change
    change_table :insurers do |t|
      t.string :name
      t.integer :parent_id
    end
  end
end
