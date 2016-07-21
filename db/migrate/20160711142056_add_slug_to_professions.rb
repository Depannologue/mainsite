class AddSlugToProfessions < ActiveRecord::Migration
  def change
    add_column :professions, :slug, :string
  end
end
