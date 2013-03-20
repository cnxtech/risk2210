require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require 'bcrypt'

if defined?(Bundler)
  Bundler.require(*Rails.groups(assets: %w(development test)))
end

module Risk2210
  class Application < Rails::Application
    config.autoload_paths += %W(#{Rails.root}/lib)

    config.after_initialize do
      Dir.glob("#{Rails.root}/app/extensions/**/*.rb").each { |extension| require extension }
    end

    config.encoding = "utf-8"
    config.filter_parameters += [:password]

    config.assets.enabled = true
    config.assets.version = '1.0'

    config.generators do |generator|
      generator.test_framework :rspec, fixture: false
      generator.stylesheets false
      generator.javascripts false
      generator.helper      false
    end

    config.settings = Hashie::Mash.new(YAML.load_file("#{Rails.root}/config/settings.yml"))[Rails.env]

    ActionMailer::Base.prepend_view_path "#{Rails.root}/app/mailer_views"
    ActionMailer::Base.smtp_settings = {
      address:        config.settings.email.address,
      port:           config.settings.email.port,
      authentication: :plain,
      user_name:      config.settings.email.username,
      password:       config.settings.email.password,
      domain:         config.settings.email.domain,
      enable_starttls_auto: true
    }

    config.password_cost = BCrypt::Engine::DEFAULT_COST

  end
end
