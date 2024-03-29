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
      intervention_types: intervention_types.map(&:restrict_for_api)
    }
  end
end
