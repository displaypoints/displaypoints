Capistrano::Configuration.instance(:must_exist).load do
  namespace :monit do
    desc "Generate the monit configuration file"
    task :setup, :roles => :app do
      require 'erb'
      on_rollback { sudo "rm /etc/monit.d/#{application}.monitrc" }

      template = File.read(File.join(File.dirname(__FILE__), "templates", stage.to_s, "monitrc.erb"))
      result = ERB.new(template).result(binding)
      put result, "/tmp/#{application}.monitrc", :mode => 0755
      sudo "mv /tmp/#{application}.monitrc /etc/monit.d/"
    end

    desc "start the monit service"
    task :start, :roles => :app do
      sudo "/etc/init.d/monit start"
    end

    desc "Get the status of your mongrels"
    task :status, :roles => :app do
      @monit_output ||= { }
      sudo "/usr/bin/monit status" do |channel, stream, data|
        @monit_output[channel[:server].to_s] ||= [ ]
        @monit_output[channel[:server].to_s].push(data.chomp)
      end
      @monit_output.each do |k,v|
        puts "#{k} -> #{'*'*55}"
        puts v.join("\n")
      end
    end
  end
end