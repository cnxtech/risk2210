require "bundler/capistrano"

set :application, "risk2210"
set :scm, :git
set :repository,  "git@github.com:nick-desteffen/risk2210.git"
set :branch, "master"
set :user, "commander"
set :deploy_to, "/opt/apps/risk2210"

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



# set :use_sudo, false
# set :rails_env, "production"
# default_run_options[:pty] = true

