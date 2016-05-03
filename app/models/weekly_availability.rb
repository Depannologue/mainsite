# == Schema Information
#
# Table name: weekly_availabilities
#
#  id                           :integer          not null, primary key
#  user_id                      :integer
#  monday_0_4_availability      :boolean          default(FALSE)
#  tuesday_0_4_availability     :boolean          default(FALSE)
#  wednesday_0_4_availability   :boolean          default(FALSE)
#  thursday_0_4_availability    :boolean          default(FALSE)
#  friday_0_4_availability      :boolean          default(FALSE)
#  saturday_0_4_availability    :boolean          default(FALSE)
#  sunday_0_4_availability      :boolean          default(FALSE)
#  monday_4_8_availability      :boolean          default(FALSE)
#  tuesday_4_8_availability     :boolean          default(FALSE)
#  wednesday_4_8_availability   :boolean          default(FALSE)
#  thursday_4_8_availability    :boolean          default(FALSE)
#  friday_4_8_availability      :boolean          default(FALSE)
#  saturday_4_8_availability    :boolean          default(FALSE)
#  sunday_4_8_availability      :boolean          default(FALSE)
#  monday_8_12_availability     :boolean          default(FALSE)
#  tuesday_8_12_availability    :boolean          default(FALSE)
#  wednesday_8_12_availability  :boolean          default(FALSE)
#  thursday_8_12_availability   :boolean          default(FALSE)
#  friday_8_12_availability     :boolean          default(FALSE)
#  saturday_8_12_availability   :boolean          default(FALSE)
#  sunday_8_12_availability     :boolean          default(FALSE)
#  monday_12_16_availability    :boolean          default(FALSE)
#  tuesday_12_16_availability   :boolean          default(FALSE)
#  wednesday_12_16_availability :boolean          default(FALSE)
#  thursday_12_16_availability  :boolean          default(FALSE)
#  friday_12_16_availability    :boolean          default(FALSE)
#  saturday_12_16_availability  :boolean          default(FALSE)
#  sunday_12_16_availability    :boolean          default(FALSE)
#  monday_16_20_availability    :boolean          default(FALSE)
#  tuesday_16_20_availability   :boolean          default(FALSE)
#  wednesday_16_20_availability :boolean          default(FALSE)
#  thursday_16_20_availability  :boolean          default(FALSE)
#  friday_16_20_availability    :boolean          default(FALSE)
#  saturday_16_20_availability  :boolean          default(FALSE)
#  sunday_16_20_availability    :boolean          default(FALSE)
#  monday_20_24_availability    :boolean          default(FALSE)
#  tuesday_20_24_availability   :boolean          default(FALSE)
#  wednesday_20_24_availability :boolean          default(FALSE)
#  thursday_20_24_availability  :boolean          default(FALSE)
#  friday_20_24_availability    :boolean          default(FALSE)
#  saturday_20_24_availability  :boolean          default(FALSE)
#  sunday_20_24_availability    :boolean          default(FALSE)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

class WeeklyAvailability < ActiveRecord::Base
  DAYS = %w(
    monday
    tuesday
    wednesday
    thursday
    friday
    saturday
    sunday
  ).freeze

  TIME_SLOTS = %w(
    0_4
    4_8
    8_12
    12_16
    16_20
    20_24
  ).freeze

  belongs_to :user

  def self.current_daily_time_slot_start_at
    now = Time.now
    hour = now.strftime("%k").to_i
    past_hours = hour % 4
    (now - past_hours.hours).beginning_of_hour
  end

  def self.current_daily_time_slot_end_at
    (WeeklyAvailability.current_daily_time_slot_start_at + 3.hours).end_of_hour
  end

  def self.current_daily_time_slot
    now = Time.now
    day_name = now.strftime("%A").downcase
    hour = now.strftime("%k").to_i
    start_h = hour - (hour % 4)
    end_h = start_h + 4
    "#{day_name}_#{start_h}_#{end_h}"
  end

  def available_now?
    self.send (WeeklyAvailability.current_daily_time_slot + '_availability').to_sym
  end
end
