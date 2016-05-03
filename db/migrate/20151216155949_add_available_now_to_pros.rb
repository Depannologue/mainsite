class AddAvailableNowToPros < ActiveRecord::Migration
  def change
    add_column :users, :available_now, :boolean, default: true
  end
end
