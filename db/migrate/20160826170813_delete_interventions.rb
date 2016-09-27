class DeleteInterventions < ActiveRecord::Migration
  def change
    Intervention.destroy_all
  end
end
