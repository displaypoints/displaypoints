set :domain, "174.129.230.153"

role :app, domain
role :web, domain
role :db,  domain

set :branch, "master"

set :upstream_port, 5000
set :ports, 5001..5004

set :haproxy_password, "thinnucnev"

set :log_level, 'error'

namespace :deploy do
  desc "automigrate & populate the database"
  task :migrate, :roles => :app, :primary => true do
    run "cd #{release_path}; bin/rake db:populate_real_data MERB_ENV=#{stage} --trace"
    run "cd #{release_path}; bin/rake db:populate_couch MERB_ENV=#{stage} --trace"
  end
end