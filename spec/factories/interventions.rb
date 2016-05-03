# == Schema Information
#
# Table name: interventions
#
#  id                     :integer          not null, primary key
#  state                  :string
#  customer_id            :integer
#  contractor_id          :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  intervention_type_id   :integer
#  price                  :decimal(, )
#  client_token_ownership :string
#  assigned_at            :datetime
#  rating                 :string
#  is_ok                  :boolean
#  opinion                :text
#  payment_method         :string
#

FactoryGirl.define do
  factory :intervention do
    kind "MyString"
state "MyString"
customer nil
contractor nil
  end

end
