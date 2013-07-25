Risk2210::Application.configure do
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = false
  config.assets.compress = true
  config.assets.digest = true
  config.assets.compile = false
  config.assets.precompile += ["risk_tracker.js", "game_results.js", "results.css"]

  config.action_mailer.default_url_options = { host: config.settings.email.domain }
  config.action_mailer.perform_deliveries = true
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify

  config.middleware.use ExceptionNotification::Rack, email: {
    sender_address:       Rails.configuration.settings.exception_notifier.sender,
    exception_recipients: Rails.configuration.settings.exception_notifier.recipients
  }

end
