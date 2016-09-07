class Api::V1::InterventionTypesFilter < Api::V1::BaseFilter

  def collection
    intervention_types = self.resource
    return self.with_associations(intervention_types)
  end
end
