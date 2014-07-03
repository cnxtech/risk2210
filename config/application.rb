require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require 'bcrypt'

Bundler.require(*Rails.groups)

module Risk2210
  class Application < Rails::Application
    config.autoload_paths += %W(#{Rails.root}/lib)

    config.after_initialize do
      Dir.glob("#{Rails.root}/app/extensions/**/*.rb").each { |extension| require extension }
    end

    config.encoding = "utf-8"
    config.assets.version = '1.0'

    config.generators do |generator|
      generator.test_framework :rspec, fixture: false
      generator.stylesheets false
      generator.javascripts false
      generator.helper      false
    end

    ActionMailer::Base.prepend_view_path "#{Rails.root}/app/mailer_views"
    ActionMailer::Base.smtp_settings = {
      address:        Rails.application.secrets.email['address'],
      port:           Rails.application.secrets.email['port'],
      authentication: :plain,
      user_name:      Rails.application.secrets.email['username'],
      password:       Rails.application.secrets.email['password'],
      domain:         Rails.application.secrets.email['domain'],
      enable_starttls_auto: true
    }

    config.password_cost = BCrypt::Engine::DEFAULT_COST
    I18n.enforce_available_locales = true
  end
end
