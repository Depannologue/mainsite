class Api::V1::ContractorFilter < Api::V1::BaseFilter
  def collection
    customers = self.resource
    return self.with_associations(interventions)
  end
end
