require "bundler/capistrano"

set :application, "risk2210"
set :repository,  "git@github.com:nick-desteffen/risk2210.git"
set :branch, "master"

set :scm, :git

role :web, "risk2210.net"
role :app, "risk2210.net"
role :db,  "risk2210.net", primary: true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

before "deploy:assets:precompile", "bundle:install"
after "deploy:restart", "deploy:cleanup"

# set :user, "nickd"
# set :ruby_version, "1.9.2-p290"
# set :use_sudo, false
# set :deploy_to, "/opt/apps/risk_tracker"
# set :rails_env, "production"


# default_run_options[:pty] = true

# set :default_environment, {
#   'PATH' => "/home/#{user}/.rvm/gems/ruby-#{ruby_version}/bin:/home/#{user}/.rvm/bin:/home/#{user}/.rvm/ruby-#{ruby_version}/bin:$PATH",
#   'RUBY_VERSION' => 'ruby 1.9.2',
#   'GEM_HOME'     => "/home/#{user}/.rvm/gems/ruby-#{ruby_version}",
#   'GEM_PATH'     => "/home/#{user}/.rvm/gems/ruby-#{ruby_version}",
#   'BUNDLE_PATH'  => "/home/#{user}/.rvm/gems/ruby-#{ruby_version}"
# }
