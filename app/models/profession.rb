# == Schema Information
#
# Table name: professions
#
#  id                     :integer          not null, primary key
#  name                  :string
#  slug                  :string

class Profession < ActiveRecord::Base
  has_many :intervention_types
  has_many :interventions, through: :intervention_types
  has_and_belongs_to_many :users
  delegate :count, to: :interventions, prefix: true

  validates :name,
            :slug,
            presence: true

  def restrict_for_api
    {
      id: self.id,
      name: self.name,
      slug: self.slug,
      intervention_types: array_serializer(self.intervention_type)
    }
  end

  def array_serializer intervention_types
      intervention_types_serialized = Array.new
      intervention_types.each do |intervention_type|
        intervention_types_serialized.push(intervention_type.restrict_for_api)
      end
      intervention_types_serialized
  end
end
