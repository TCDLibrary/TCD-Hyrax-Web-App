# config valid for current version and patch releases of Capistrano
lock "~> 3.12.0"

set :application, "TCD-Hyrax-Web-App"
set :repo_url, "https://github.com/joelakes/TCD-Hyrax-Web-App.git"
#set :rvm_ruby_version, '2.5.1'

# JL : see notes when installing capistrano 21/03/2019
set :passenger_restart_with_touch, true

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref master`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/TCD-Hyrax-Web-App"

set :migration_role, :app

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, "log", "tmp/derivatives", "tmp/uploads", "public/data/ingest", "public/branding", "tmp/imports", "public/data/tidy"
#, "datastore"
# JL : note this creates a symlink from public/branding to shared/public/branding

#desc "Symlink shared config files"
#task :symlink_config_files do
#    run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
#end

# JL : this is to fix problem with passwordless sudo for sidekiq
set :pty, true

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# JL : 10/07/2019
# JL : Doesn't use the capistrano-sidekiq Gem because that is unsupported
namespace :sidekiq do

  task :restart do
    invoke 'sidekiq:stop'
  end

  before 'deploy:finished', 'sidekiq:restart'

  task :stop do
    on roles(:app) do
      within current_path do
        #pid = p capture "sudo -S -u hyraxuser -g digcoll ps aux | grep sidekiq | awk '{print $2}' | sed -n 1p"
        #execute("sudo -S -u hyraxuser -g digcoll kill -9 #{pid}")
        execute ("sudo systemctl restart sidekiq")
      end
    end
  end
end

namespace :deploy do
  desc 'Config bundler'

  task :config_bundler do
    on roles(/.*/) do
      execute :bundle, 'config', '--local deployment', true
      execute :bundle, 'config', '--local', 'without', "development:test"
      execute :bundle , 'config', '--local', 'path', shared_path.join('bundle')
    end
  end
end

before 'bundler:install', 'deploy:config_bundler'
