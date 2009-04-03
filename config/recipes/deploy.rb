dir = File.dirname(__FILE__)
require File.join(dir, 'database')
require File.join(dir, 'ec2')
require File.join(dir, 'haproxy')
require File.join(dir, 'monit')
require File.join(dir, 'nginx')
require File.join(dir, 'thor')

Capistrano::Configuration.instance(:must_exist).load do
  default_run_options[:pty] = true if respond_to?(:default_run_options)
  ssh_options[:forward_agent] = true
  set :keep_releases, 3

  namespace :deploy do
    desc "creates a start script in bin/start"
    task :generate_start_script, :roles => :app do
      require 'erb'
      on_rollback { sudo "rm /etc/monit.d/#{application}.monitrc" }

      template = File.read(File.join(File.dirname(__FILE__), "templates", stage.to_s, "start.erb"))
      result = ERB.new(template).result(binding)
      put result, "#{release_path}/bin/start", :mode => 0755
      sudo "chown app.app #{release_path}/bin/start"
    end

    desc "migrate up the database"
    task :migrate, :roles => :app, :primary => true do
      run "cd #{release_path}; bin/rake db:migrate:up MERB_ENV=#{stage}"
    end

    desc "start the application via monit"
    task :start, :roles => :app do
      monit.start
      sudo "/usr/bin/monit start all -g merb_#{application}"
    end

    desc "restart the application via monit"
    task :restart, :roles => :app do
      sudo "/usr/bin/monit restart all -g merb_#{application}"
    end

    desc "Tail the nginx access logs for this application"
    task :tail_logs, :roles => :app do
      run "tail -f #{shared_path}/log/#{application}.log" do |channel, stream, data|
        puts "#{channel[:server]}: #{data}" unless data =~ /^10\.[01]\.0/ # skips lb pull pages
        break if stream == :err    
      end
    end

    desc "Enter an application console"
    task :console, :roles => :app, :primary => true do
      input = ''
      run "cd #{current_path}; bin/merb -i -e #{stage}" do |channel, stream, data|
        next if data.chomp == input.chomp || data.chomp == ''
        print data
        channel.send_data(input = $stdin.gets) if data =~ /^irb\(\w+\)/
      end
    end
  end

  before("deploy:setup") do
    ec2.setup
    haproxy.setup
    nginx.setup
    monit.setup
  end

  after("deploy:setup") do
    sudo "chown -R app.app /data/merb"
  end

  before("deploy:cold") do
    db.start
    haproxy.start
    nginx.start
  end

  after("deploy:update_code") do
    thor.redeploy
    deploy.generate_start_script
  end
end
