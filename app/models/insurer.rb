class Insurer < ActiveRecord::Base
  has_many :interventions
end
