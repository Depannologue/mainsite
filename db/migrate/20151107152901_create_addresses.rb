class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :intervention
      t.string :firstname
      t.string :lastname
      t.string :address1
      t.string :address2
      t.string :zipcode
      t.string :city

      t.timestamps null: false
    end
  end
end
