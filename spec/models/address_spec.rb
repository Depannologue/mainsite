# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  firstname        :string
#  lastname         :string
#  address1         :string
#  address2         :string
#  zipcode          :string
#  city             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  latitude         :float
#  longitude        :float
#  phone_number     :string
#  addressable_id   :integer
#  addressable_type :string
#

require 'rails_helper'

RSpec.describe Address, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
