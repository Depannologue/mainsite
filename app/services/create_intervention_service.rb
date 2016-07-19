class CreateInterventionService
  def self.perform(address, customer, intervention_type)
    new.perform(address, customer, intervention_type)
  end

  def perform(address, customer, intervention_type)
    # Duplicate the address with a new id for the intervention
    intervention_address = address.dup
    intervention_address.save
    # create an intervention
    persist intervention_address, customer, intervention_type
  end


  private

  def persist intervention_address, customer, intervention_type
    intervention = Intervention.create(address: intervention_address, customer: customer, intervention_type: intervention_type).valid? ? true : false
  end
end
