# == Schema Information
#
# Table name: intervention_types
#
#  id                :integer          not null, primary key
#  kind              :string
#  short_description :string
#  price             :decimal(, )
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  description       :string
#

class InterventionType < ActiveRecord::Base
  KINDS = %w(
    closed_door
    locked_door
  ).freeze

  belongs_to :profession

  validates :profession_id,
            :short_description,
            :price,
            presence: true

  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
