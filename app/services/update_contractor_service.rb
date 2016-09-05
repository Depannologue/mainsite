class UpdateContractorService
  def self.perform(permitted_params, id)
    new.perform(permitted_params, id)
  end

  def perform(permitted_params, id)
    persist(permitted_params, id)
  end

  private

  def persist(permitted_params, id)

     if permitted_params.has_key?(:exceptional_availabilities_attributes) && permitted_params[:exceptional_availabilities_attributes].has_key?('0')
      # permitted_params[:user].delete(:exceptional_availabilities_attributes) if permitted_params[:exceptional_availabilities_attributes]['0'][:available_now] == (@contractor.available_now? ? '1' : '0')
     end
    contractor = User.contractors.find_by_id(id)
    contractor.update_attributes permitted_params
    contractor
  end

end
