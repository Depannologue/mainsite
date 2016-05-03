class CreateExceptionalAvailabilities < ActiveRecord::Migration
  def change
    create_table :exceptional_availabilities do |t|
      t.belongs_to :user
      t.boolean :available_now

      t.timestamps null: false
    end

    remove_column :users, :available_now, :boolean, default: true
  end
end
