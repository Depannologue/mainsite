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

FactoryGirl.define do
  factory :zip_code do
    zip_code "MyString"
area nil
  end

end
