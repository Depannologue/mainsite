class AddIndexToZipCode < ActiveRecord::Migration
  def change
    add_index :zip_codes, :zipcode, :unique => true
  end
end

