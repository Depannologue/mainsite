class CreateInsurers < ActiveRecord::Migration
  def change
    create_table :insurers do |t|
      t.string :name
      t.integer :parent_id
    end
  end
end
