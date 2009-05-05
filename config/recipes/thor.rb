Capistrano::Configuration.instance(:must_exist).load do
  namespace :thor do
    desc "Generate the monit configuration file"
    task :setup, :roles => :app do
    end

    task :redeploy, :roles => :app do
      run "cd #{release_path}; bin/thor merb:gem:redeploy"
    end
  end
end
