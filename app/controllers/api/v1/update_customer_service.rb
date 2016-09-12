class UpdateCustomerService
  def self.perform(permitted_params, id)
    new.perform(permitted_params, id)
  end

  def perform(permitted_params, id)
    persist(permitted_params, id)
  end

  private

  def persist(permitted_params, id)
    customers = User.customers.find_by_id(id)
    customers.update_attributes permitted_params
    customers
  end

end
