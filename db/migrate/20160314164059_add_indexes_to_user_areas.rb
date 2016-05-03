class AddIndexesToUserAreas < ActiveRecord::Migration
  def self.up
    add_index :user_areas , [:user_id , :area_id] , :unique => true
  end

  def self.down
    drop_index :user_areas, [:user_id , :area_id]
  end
end