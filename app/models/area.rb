# == Schema Information
#
# Table name: areas
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Area < ActiveRecord::Base
  has_many :zip_codes, dependent: :destroy
  has_and_belongs_to_many :users, join_table: :users_areas

  accepts_nested_attributes_for :zip_codes, reject_if: :all_blank, allow_destroy: true

  has_many :user_areas
  has_many :users, through: :user_areas, class_name: 'User', inverse_of: :areas

  # scope :available, lambda { |user|
  #   where.not(id: user.user_areas.pluck(:area_id)) 
  # }
end
