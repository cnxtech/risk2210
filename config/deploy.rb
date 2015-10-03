set :application, 'risk2210'
set :repo_url, 'git@github.com:nick-desteffen/risk2210.git'
set :branch, "master"
set :deploy_to, "/var/www/apps/risk2210"
set :scm, :git
set :format, :pretty
set :log_level, :info
set :pty, true
set :linked_files, %w{config/secrets.yml}
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :keep_releases, 5
set :passenger_restart_with_sudo, true

namespace :deploy do
  after :finishing, 'deploy:cleanup'
end

namespace :db do

  desc 'Refresh development database with copy from remote'
  task :fetch do
    on roles(:app) do
      temp_path = "./tmp"
      execute "cd /tmp && mongodump -db risk2210_#{fetch(:rails_env)} -o /tmp && tar --remove-files -czf risk2210_#{fetch(:rails_env)}.tar.gz risk2210_#{fetch(:rails_env)}"
      download! "/tmp/risk2210_#{fetch(:rails_env)}.tar.gz", "#{temp_path}/risk2210_#{fetch(:rails_env)}.tar.gz"
      system "cd #{temp_path} && tar -xzvf risk2210_#{fetch(:rails_env)}.tar.gz"
      system "mongorestore --drop -d risk2210_development #{temp_path}/risk2210_#{fetch(:rails_env)}"
    end
  end

end
