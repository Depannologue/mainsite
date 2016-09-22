class AddAuthIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_id, :string


  end
end
