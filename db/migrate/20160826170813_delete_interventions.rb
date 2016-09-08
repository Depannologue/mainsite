class DeleteInterventions < ActiveRecord::Migration
  def change
    Intervention.delete_all

  end
end
