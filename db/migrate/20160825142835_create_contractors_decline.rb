class CreateContractorsDecline < ActiveRecord::Migration
  def change
    create_table :contractors_declines do |t|
      t.references :user, index: true
      t.references :intervention, index: true
      t.timestamps
    end
  end
end
