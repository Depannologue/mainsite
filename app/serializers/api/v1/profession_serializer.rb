class Api::V1::ProfessionSerializer < Api::V1::BaseSerializer
  attributes :id, :name, :slug, :intervention_type, :created_at, :updated_at
end
