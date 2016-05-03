# == Schema Information
#
# Table name: user_areas
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  area_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserArea < ActiveRecord::Base
  belongs_to :user
  belongs_to :area
end
