class AutoCloseAllJob < ActiveJob::Base
  queue_as :default

  def perform
    puts "Auto close all interventions START ..."
    now = Time.now
    _7_days_ago = now - 7.days
    Intervention.pro_on_the_road
                .where(assigned_at: _7_days_ago.beginning_of_day.._7_days_ago.end_of_day).each do |intervention|
      intervention.close!
      puts "Intervention (id: #{intervention.id}) close!"
    end
  end
end
