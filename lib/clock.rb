require 'clockwork'
require './config/boot'
require './config/environment'
require 'sidekiq'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every 1.minute, 'test.time' do
    puts "Time is #{Time.now}"
  end

  every 1.day, 'interventions.auto_close_all', at: '02:00' do
    AutoCloseAllJob.perform_async
  end
end
