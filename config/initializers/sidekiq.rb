Sidekiq.configure_client do |config|
  config.redis = { url: 'unix://home/deploy/redis/redis.sock' }
end
