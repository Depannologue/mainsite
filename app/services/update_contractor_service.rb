class UpdateContractorService
  def self.perform(permitted_params, id)
    new.perform(permitted_params, id)
  end

  def perform(permitted_params, id)
    persist(permitted_params, id)
  end

  private

  def persist(permitted_params, id)
    contractor = User.contractors.find_by_id(id)
    contractor.update_attributes permitted_params
    contractor
  end

end
