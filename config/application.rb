require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Depannologue
  class Application < Rails::Application

    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/services)
    config.eager_load_paths += %W(#{config.root}/app/services)
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.i18n.default_locale = :fr
    config.time_zone = 'Paris'

    config.assets.enabled = true
    config.assets.precompile += %w(
      *.png *.gif
      admin.css
      devise.css
      client.css
      pro.css
      client/application.js
      pro/application.js
    )

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.active_job.queue_adapter = :sidekiq

    Twilio.configure do |config|
      config.account_sid = Rails.application.secrets.twilio_account_sid
      config.auth_token  = Rails.application.secrets.twilio_auth_token
    end
  end
end
