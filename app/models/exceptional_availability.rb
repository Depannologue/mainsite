# == Schema Information
#
# Table name: exceptional_availabilities
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  available_now :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ExceptionalAvailability < ActiveRecord::Base

  belongs_to :user

end
