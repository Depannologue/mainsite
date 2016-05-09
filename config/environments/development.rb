Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :mailgun
  config.action_mailer.mailgun_settings = {
    api_key: Rails.application.secrets.mailgun_api_key,
    domain: Rails.application.secrets.mailgun_domain
  }
  config.action_mailer.default_options = {
    from: Rails.application.secrets.default_from
  }
  config.action_mailer.default_url_options = {
    domain: Rails.application.secrets.host,
    host:   Rails.application.secrets.host,
    port:   Rails.application.secrets.port
  }

  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true
end
