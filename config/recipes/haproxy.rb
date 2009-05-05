Capistrano::Configuration.instance(:must_exist).load do
  namespace :haproxy do
    desc "Generate the haproxy.cfg file"
    task :setup, :roles => :app do
      require 'erb'

      template = File.read(File.join(File.dirname(__FILE__), "templates", stage.to_s, "haproxy.cfg.erb"))
      result = ERB.new(template).result(binding)
      put result, "/tmp/haproxy.cfg", :mode => 0755
      sudo "mv /tmp/haproxy.cfg /etc"
    end

    desc "start the haproxy service"
    task :start, :roles => :app do
      sudo "/etc/init.d/haproxy start"
    end
  end
end