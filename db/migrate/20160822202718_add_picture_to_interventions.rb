class AddPictureToInterventions < ActiveRecord::Migration
  def change
    add_column :interventions, :picture, :text

  end
end
