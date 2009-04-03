Capistrano::Configuration.instance(:must_exist).load do
  namespace :ec2 do
    desc "mount the EBS device /dev/sdh to /data"
    task :mount_ebs, :roles => [:app, :db] do
      sudo "chmod 777 /tmp"
      sudo "mount -t ext3 /dev/sdh /data"
    end

    desc "setup an ec2 instance"
    task :setup, :roles => [:app, :db] do
      ec2.mount_ebs
    end
  end
end