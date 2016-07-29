class Api::V1::InterventionSerializer < Api::V1::BaseSerializer
  attributes :id, :customer, :contractor, :address, :rating, :immediate_intervention, :intervention_date, :assigned_at, :created_at, :updated_at, :intervention_type
end
