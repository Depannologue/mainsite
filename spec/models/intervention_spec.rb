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

require 'rails_helper'

RSpec.describe Intervention, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
