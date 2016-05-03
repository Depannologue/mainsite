class CreateUserAreas < ActiveRecord::Migration
  def change
    create_table :user_areas do |t|
      t.references :user, index: true
      t.references :area, index: true

      t.timestamps
    end
  end

end
