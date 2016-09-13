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

class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true

  attr_accessor :place




  phony_normalize :phone_number, default_country_code: 'FR'

  validates :phone_number, phony_plausible: true

  validates :zipcode,
            :city,
            :address1,
            :phone_number,
            presence: true,
            if: proc { |address|
              address.addressable_type == 'Intervention'
            }
end
