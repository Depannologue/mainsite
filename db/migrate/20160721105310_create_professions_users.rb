class CreateProfessionsUsers < ActiveRecord::Migration
  def change
    create_table :professions_users  do |t|
      t.references :user, index: true
      t.references :profession, index: true
      t.timestamps
    end
  end
end
