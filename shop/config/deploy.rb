set :application, "myshop"
set :repository,  "myshop@git.fkis.ru:/home/repo/myshop.git"

set :scm, :git
set :git_enable_submodules, 1
set :branch, "master"
set :scm_verbose, true
set :deploy_via, :remote_cache
set :rails_env, "production"
set :ssh_options, { :forward_agent => true }
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "s1.fkis.ru"                          # Your HTTP server, Apache/etc
role :app, "s1.fkis.ru"                          # This may be the same as your `Web` server
role :db,  "s1.fkis.ru", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts


set :user, 'myshop' # пользователь удалённого сервера
set :use_sudo, false # не запускать команды под sudo

# Директория приложения на удалённом хостинге
set :app_dir, "/home/#{user}" # /home/myuser/myproject/

# Директория, куда будет делаться checkout из репозитория
set :deploy_to, "#{app_dir}" # /home/myuser/myproject/deploy

require "bundler/capistrano"


# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
   task :assets do
      run "cd #{release_path}; bundle exec rake assets:precompile RAILS_ENV=production"
   end
 end

on :after, "deploy:assets", :only => "bundle:install" 

