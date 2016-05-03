class CreateZipCodes < ActiveRecord::Migration
  def change
    create_table :zip_codes do |t|
      t.string :zipcode
      t.belongs_to :area, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
