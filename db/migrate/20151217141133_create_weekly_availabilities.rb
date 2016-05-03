class CreateWeeklyAvailabilities < ActiveRecord::Migration
  def up
    drop_table :availabilities

    create_table :weekly_availabilities do |t|
      t.belongs_to :user

      %w(
        0_4
        4_8
        8_12
        12_16
        16_20
        20_24
      ).freeze.each do |from_to|
        %w(
          monday
          tuesday
          wednesday
          thursday
          friday
          saturday
          sunday
        ).freeze.each do |day|
          t.boolean :"#{day}_#{from_to}_availability", default: false
        end
      end

      t.timestamps null: false
    end
  end

  def down
    drop_table :weekly_availabilities

    create_table :availabilities do |t|
      t.belongs_to :user

      %w(
        0_4
        4_8
        8_12
        12_16
        16_20
        20_24
      ).freeze.each do |from_to|
        %w(
          monday
          tuesday
          wednesday
          thursday
          friday
          saturday
          sunday
        ).freeze.each do |day|
          t.boolean :"#{day}_#{from_to}_availability", default: false
        end
      end

      t.timestamps null: false
    end
  end
end
