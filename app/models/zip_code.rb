# == Schema Information
#
# Table name: zip_codes
#
#  id         :integer          not null, primary key
#  zipcode    :string
#  area_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ZipCode < ActiveRecord::Base
  belongs_to :area
  validates :zipcode, zipcode: { country_code: :fr }, presence: true, uniqueness: true

  def self.managed? code
    true if find_by(zipcode: code)
  end
  def self.getZipcode zipcode
    find_by(zipcode: zipcode)
  end
end
