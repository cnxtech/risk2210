require "bundler/capistrano"
require "capistrano_colors"

set :application, "risk2210"
set :scm, :git
set :repository,  "git@github.com:nick-desteffen/risk2210.git"
set :branch, "master"
set :user, "nickd"
set :deploy_to, "/var/www/apps/risk2210"
set :use_sudo, false

default_run_options[:pty] = true

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

namespace :db do
  task :fetch do
    temp_path = "./tmp"
    run "cd /tmp && mongodump -db risk2210_production -o /tmp && tar --remove-files -czf risk2210_production.tar.gz risk2210_production"
    download "/tmp/risk2210_production.tar.gz", "#{temp_path}/risk2210_production.tar.gz"
    system "cd #{temp_path} && tar -xzvf risk2210_production.tar.gz"
    system "mongorestore -d risk2210_development #{temp_path}/risk2210_production"
  end
end

before "deploy:assets:precompile", "bundle:install"
after "deploy:restart", "deploy:cleanup"
