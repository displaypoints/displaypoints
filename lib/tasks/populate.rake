namespace :db do
    desc "populate the database with some randomly generated fixtures"
    task :populate => :automigrate do
      require 'dm-sweatshop'
      require Merb.root / :spec / :fixtures

      media = Dir[Merb.root / :assets / :images / "**/*.{jpg,jpeg,png}"]

      puts "Generating Locations"
      40.of {City.gen}
      40.of {Zipcode.gen}

      puts "Generating Assets"
      100.of {Display.gen}
      100.of {Router.gen}
      100.of {Charger.gen}

      #puts "Generating Corporations"
      #20.of {Corporation.gen}
      #20.of {Corporation.gen}

      puts "Generating Users"
      c = Corporation.gen(:name => "Downtown Cartel LLC", :master => true)
      u = User.create(:name => "Aaron Farnham", :email => "aaron@downtowncartel.com", :password => "test", :password_confirmation => "test", :corporation => c)
      CorpRole.create(:user => u, :role => :dp, :admin => true)

      u = User.create(:name => "Brian Smith", :email => "brian@isawesome.com", :password => "test", :password_confirmation => "test", :corporation => c)
      CorpRole.create(:user => u, :role => :dp, :admin => true)
            
      u = User.create(:name => "DP User", :email => "dp@downtowncartel.com", :password => "test", :password_confirmation => "test", :corporation => c)
      CorpRole.create(:user => u, :role => :dp, :admin => false)
      
      c = Corporation.gen(:name => "AdCorp", :master => false)
      u = User.create(:name => "Ad Admin", :email => "adadmin@adcorp.com", :password => "test", :password_confirmation => "test", :corporation => c)
      CorpRole.create(:user => u, :role => :ad, :admin => true)

      u = User.create(:name => "Ad User", :email => "aduser@adcorp.com", :password => "test", :password_confirmation => "test", :corporation => c)
      CorpRole.create(:user => u, :role => :ad, :admin => false)

      c = Corporation.gen(:name => "VenueCorp", :master => false)
      u = User.create(:name => "Venue Admin", :email => "venueadmin@adcorp.com", :password => "test", :password_confirmation => "test", :corporation => c)
      CorpRole.create(:user => u, :role => :venue, :admin => true)

      u = User.create(:name => "Venue User", :email => "venueuser@adcorp.com", :password => "test", :password_confirmation => "test", :corporation => c)
      CorpRole.create(:user => u, :role => :venue, :admin => false)
      
      puts "Generating Venues"
      10.of {Venue.gen}

      puts "Generating Root Pages"
      50.of {Page.gen(:root, :media_data => tmp_media_data(media.pick))}
      puts "Generating Child Pages"
      100.of {Page.gen(:zero_depth, :media_data => tmp_media_data(media.pick))}

      puts "Generating Tags"
      10.of {Tag.gen}

#      puts "Generating Content Items"
#      20.of {ContentItem.gen(:advertisement)}

      puts "Generating Publish Groups"
      20.of {PublishGroup.gen}

      puts "Generating State Assigments"
      20.of {StateAssignment.gen}

      puts "Generating City Assigments"
      20.of {CityAssignment.gen}

      puts "Generating Zipcode Assigments"
      20.of {ZipcodeAssignment.gen}

      puts "Generating Venue Assigments"
      20.of {VenueAssignment.gen}

#      puts "Generating Campaigns"
#      10.of {Campaign.gen}
  end
end

def tmp_media_data(file)
  tmp = Tempfile.new(File.basename(file))
  tmp.close
  FileUtils.cp file, tmp.path
 
  type = case File.extname(file)
  when '.png' then "image/png"
  when '.jpeg', '.jpg' then "image/jpeg"
  end
 
  Mash.new(:tempfile => tmp, :filename => File.basename(file), :content_type => type)
end
