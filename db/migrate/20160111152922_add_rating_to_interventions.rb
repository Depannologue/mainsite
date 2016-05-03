class AddRatingToInterventions < ActiveRecord::Migration
  def change
    add_column :interventions, :rating, :string
  end
end
