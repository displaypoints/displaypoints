Capistrano::Configuration.instance(:must_exist).load do
  namespace :db do
    desc "Start the database service"
    task :start, :roles => :db do
      sudo "/etc/init.d/postgresql start"
    end
  end
end