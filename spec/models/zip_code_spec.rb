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

require 'rails_helper'

RSpec.describe ZipCode, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
