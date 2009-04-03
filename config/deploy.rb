`ssh-add` #http://groups.google.com/group/github/browse_thread/thread/051fe195161d278d
require File.join(File.dirname(__FILE__), 'recipes', 'deploy')

set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "dp-admanager"
set :user, 'app'
set :runner, 'app'

set :repository,  "git@github.com:downtowncartel/dp-admanager.git"
set :scm, :git
set :deploy_to, "/data/merb/#{application}"
set :deploy_via, :remote_cache

after('deploy:symlink') do
  run "mkdir -p #{shared_path}/public/uploads"
  run "ln -nfs #{shared_path}/public/uploads #{release_path}/public/uploads"
end