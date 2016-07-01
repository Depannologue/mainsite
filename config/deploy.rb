# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'depannologue'
set :repo_url, 'git@github.com:Depannologue/mainsite.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deploy/app/depannologue'

# Default value for :scm is :git
set :user, "deploy"
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
after 'deploy:publishing', 'unicorn:restart'
after 'unicorn:restart', 'sidekiq:restart'

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

namespace :unicorn do
  [:start, :stop, :status, :restart].each do | command_sym |
    desc "#{command_sym} unicorn service"
    task command_sym do
      on roles(:admin, :web), in: :parallel do |host|
        sudo "/etc/init.d/unicorn_depannologue #{command_sym}"
      end
    end
  end
end

namespace :sidekiq do
  [:start, :stop, :status, :restart].each do | command_sym |
    desc "#{command_sym} sidekiq services"
    task command_sym do
      on roles(:admin, :web), in: :parallel do |host|
        sudo "/etc/init.d/init_sidekiq.sh #{command_sym}"
      end
    end
  end
end
