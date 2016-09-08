#== Schema Information
#
# Table name: professions_users
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  profession_id          :string

class ContractorsDecline < ActiveRecord::Base
  belongs_to :user
  belongs_to :intervention
end
