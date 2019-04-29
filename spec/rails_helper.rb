ENV["RAILS_ENV"] = 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'database_cleaner'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.render_views
  config.include(FactoryBot::Syntax::Methods)

  config.before(:suite) do
    DatabaseCleaner.clean
    load_factions
    load_maps
    DatabaseCleaner.strategy = :truncation, {except: ["factions", "maps", "continents"]}
    DatabaseCleaner.orm = "mongoid"
    #FactoryBot.lint
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

end

def login(player)
  session[:player_id] = player.id
end

def load_factions
  load("#{Rails.root}/db/factions.rb")
end

def load_maps
  load("#{Rails.root}/db/maps.rb")
end
