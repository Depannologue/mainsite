# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                  :string

class Profession < ActiveRecord::Base
  has_many :intervention_type

end
