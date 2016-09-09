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
end
