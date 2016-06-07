Sidekiq.configure_client do |config|
  config.redis = { url: 'unix://var/run/redis/redis.sock' }
end
