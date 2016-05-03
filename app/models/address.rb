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

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.address1 = [geo.street_number, geo.route].reject { |e| e.blank? }.join(' ')
      obj.zipcode = geo.postal_code
      obj.city    = geo.city
    end
  end
  geocoded_by :place
  before_validation do
    if (latitude_changed? || longitude_changed?) &&
      latitude.present? &&
      longitude.present?
      reverse_geocode
    elsif (address1_changed? || zipcode_changed? || city_changed?) &&
      address1.present? &&
      zipcode.present? &&
      city.present?
      self.place = [
        address1,
        [zipcode, city].reject { |e| e.blank? }.join(' ')
      ].reject { |e| e.blank? }.join(', ')
      geocode
    end
  end

  phony_normalize :phone_number, default_country_code: 'FR'

  validates :phone_number, phony_plausible: true
  validates :zipcode,
            :city,
            presence: true
  validates :address1,
            :phone_number,
            presence: true,
            if: proc { |address|
              address.addressable_type == 'Intervention'
            }
end
