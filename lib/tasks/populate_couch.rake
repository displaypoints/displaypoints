namespace :db do
    desc "populate couch with some randomly generated fixtures"
    task :populate_couch => :merb_env do
      require 'dm-sweatshop'
      require Merb.root / :spec / :fixtures / :page_analytic_fix
      
      puts "Be patient, this takes a while"
      
      puts "Pushing the views"
      PageAnalytic.auto_migrate!
      
      [:link, :auto_rotation, :user_rotation, :touch].each do |type|
        n = 1000
        puts "Generating #{n} analytics for the #{type} action"
        n.times{ PageAnalytic.gen(type)}
      end
    end
end