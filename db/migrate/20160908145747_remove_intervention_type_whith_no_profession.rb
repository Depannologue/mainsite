class RemoveInterventionTypeWhithNoProfession < ActiveRecord::Migration
  def change
    InterventionType.delete_all :profession_id => nil
  end
end
