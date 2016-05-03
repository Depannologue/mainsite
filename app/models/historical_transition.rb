# == Schema Information
#
# Table name: historical_transitions
#
#  id                :integer          not null, primary key
#  historisable_id   :integer
#  historisable_type :string
#  event             :string
#  from              :string
#  to                :string
#  processed_at      :datetime
#  created_at        :datetime
#  updated_at        :datetime
#

class HistoricalTransition < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  belongs_to :historisable, polymorphic: true

  validates :event, :from, :to, presence: true
end
