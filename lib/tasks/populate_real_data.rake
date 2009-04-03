require 'pp'

namespace :db do
    desc "populate the database with users"
    task :populate_real_data => :automigrate do
      wot_admin, grapevine, integer_admin, integer_corp, dtc = nil, nil, nil, nil, nil
      puts "Generating Users"

      dtc = corporation(:name => "Downtown Cartel LLC", :master => true, :advertiser => false) do |c|
        user(:name => "Aaron Farnham", :email => "aaron@downtowncartel.com", :password => "test", :password_confirmation => "test") do |u|
          role(:user => u, :role => :dp, :admin => true, :corporation => c)
        end

        user(:name => "Brian Smith", :email => "brian@downtowncartel.com", :password => "test", :password_confirmation => "test") do |u|
          role(:user => u, :role => :dp, :admin => true, :corporation => c)
        end

        user(:name => "Ben Burkert", :email => "ben@downtowncartel.com", :password => "test", :password_confirmation => "test") do |u|
          role(:user => u, :role => :dp, :admin => true, :corporation => c)
        end
      end

      corporation(:name => "DisplayPoints", :master => true, :advertiser => false) do |c|
        dub = user(:name => "Dub Dublin", :email => "dub@displaypoints.com", :password => "test", :password_confirmation => "test") do |u|
          role(:user => u, :role => :dp, :admin => true, :corporation => c)
        end

        user(:name => "Brandon Willard", :email => "brandon@displaypoints.com", :password => "test", :password_confirmation => "test") do |u|
          role(:user => u, :role => :dp, :admin => true, :corporation => c)
        end
        
        user(:name => "Display User", :email => "displays@displaypoints.com", :password => "gNeqX0b7", :password_confirmation => "gNeqX0b7") do |u|
          role(:user => u, :role => :dp, :admin => false, :corporation => c)
        end
      end

      integer_corp = corporation(:name => "Integer", :master => false, :advertiser => true) do |c|
        integer_admin = user(:name => "Integer Admin", :email => "admin@integer.com", :password => "test", :password_confirmation => "test") do |u|
          role(:user => u, :role => :ad, :admin => true, :corporation => c)
        end
      end

      vencorp = corporation(Corporation, :name => "Wings Over Texas", :brand => "Hooters", :advertiser => false) do |c|
        wot_admin = user(:name => "WoT Admin", :email => "admin@wot.com", :password => "test", :password_confirmation => "test") do |u|
          role(:user => u, :role => :venue, :admin => true, :corporation => c)
        end
      end

      state = State.create(:name => "Texas", :code => "TX")
      city = City.create(:name => "Lewisville", :state => state)
      zipcode = Zipcode.create(:code => "75067", :city => city)
      lville = Venue.create(:name => "Hooters - Lewisville",
                       :street => "1980 S Stemmons Fwy",
                       :city => city,
                       :state => state,
                       :zipcode => zipcode,
                       :corp => vencorp)

      city = City.create(:name => "Grapevine", :state => state)
      zipcode = Zipcode.create(:code => "76051", :city => city)
      gvine = Venue.create(:name => "Hooters - Grapevine",
                       :street => "1711 Cross Roads Dr",
                       :city => city,
                       :state => state,
                       :zipcode => zipcode,
                       :corp => vencorp)
      
      city = City.create(:name => "North Richland Hills", :state => state)
      zipcode = Zipcode.create(:code => "76180", :city => city)
      nrh = Venue.create(:name => "Hooters - North Richland Hills",
                       :street => "7669 Boulevard 26",
                       :city => city,
                       :state => state,
                       :zipcode => zipcode,
                       :corp => vencorp)

      city = City.create(:name => "Bryan", :state => state)
      zipcode = Zipcode.create(:code => "77803", :city => city)
      dtc_venue = Venue.create (:name => "Downtown Cartel Test Venue",
                                :street => "211A W WMJ Bryan Pkwy",
                                :city => city,
                                :state => state,
                                :zipcode => zipcode,
                                :corp => dtc)

      display_macs = {
        "00:30:0d:27:1a:75" => lville,
        "00:30:0d:27:1a:76" => lville,
        "00:30:0d:27:1a:77" => lville,
        "00:30:0d:27:1a:7a" => lville,
        "00:30:0d:27:1a:7b" => lville,
        "00:30:0d:27:1a:7f" => lville,
        "00:30:0d:27:1a:81" => lville,
        "00:30:0d:27:1a:88" => lville,
        "00:30:0d:27:1a:94" => lville,
        "00:30:0d:27:1a:96" => lville,
        "00:30:0d:27:1a:9c" => lville,
        "00:30:0d:27:1a:a4" => lville,
        "00:30:0d:27:1a:a6" => lville,
        "00:30:0d:27:1a:a7" => lville,
        "00:30:0d:27:1a:aa" => lville,
        "00:30:0d:27:1a:b2" => lville,
        "00:30:0d:27:1a:bb" => lville,
        "00:30:0d:27:1a:bf" => lville,
        "00:30:0d:27:1a:b0" => lville,
        "00:30:0d:27:1a:c1" => lville,
        "00:30:0d:27:1a:c5" => lville,
        "00:30:0d:27:1a:cf" => lville,
        "00:30:0d:27:1a:d1" => lville,
        "00:30:0d:27:1b:07" => lville,
        "00:30:0d:27:1b:0c" => lville,
        "00:30:0d:27:1b:12" => lville,
        "00:30:0d:27:1b:13" => lville,
        "00:30:0d:27:1b:18" => lville,
        "00:30:0d:27:1b:1b" => lville,
        "00:30:0d:27:1b:1c" => lville,
        "00:30:0d:27:1a:7c" => gvine,
        "00:30:0d:27:1a:7e" => gvine,
        "00:30:0d:27:1a:86" => gvine,
        "00:30:0d:27:1a:87" => gvine,
        "00:30:0d:27:1a:8b" => gvine,
        "00:30:0d:27:1a:8e" => gvine,
        "00:30:0d:27:1a:8f" => gvine,
        "00:30:0d:27:1a:97" => gvine,
        "00:30:0d:27:1a:9b" => gvine,
        "00:30:0d:27:1a:9d" => gvine,
        "00:30:0d:27:1a:9e" => gvine,
        "00:30:0d:27:1a:a2" => gvine,
        "00:30:0d:27:1a:a3" => gvine,
        "00:30:0d:27:1a:95" => gvine,
        "00:30:0d:27:1a:70" => gvine,
        "00:30:0d:27:1a:ad" => gvine,
        "00:30:0d:27:1a:bc" => gvine,
        "00:30:0d:27:1a:bd" => gvine,
        "00:30:0d:27:1a:c3" => gvine,
        "00:30:0d:27:1a:c7" => gvine,
        "00:30:0d:27:1a:c8" => gvine,
        "00:30:0d:27:1a:c9" => gvine,
        "00:30:0d:27:1a:ac" => gvine,
        "00:30:0d:27:1a:b6" => gvine,
        "00:30:0d:27:1a:cc" => gvine,
        "00:30:0d:27:1a:d2" => gvine,
        "00:30:0d:27:1b:10" => gvine,
        "00:30:0d:27:1b:11" => gvine,
        "00:30:0d:27:1b:17" => gvine,
        "00:30:0d:27:1b:19" => gvine,
        "00:30:0d:27:1a:c0" => nrh,
        "00:30:0d:27:1a:72" => nrh,
        "00:30:0d:27:1a:73" => nrh,
        "00:30:0d:27:1a:7d" => nrh,
        "00:30:0d:27:1a:80" => nrh,
        "00:30:0d:27:1a:83" => nrh,
        "00:30:0d:27:1a:89" => nrh,
        "00:30:0d:27:1a:90" => nrh,
        "00:30:0d:27:1a:91" => nrh,
        "00:30:0d:27:1a:92" => nrh,
        "00:30:0d:27:1a:99" => nrh,
        "00:30:0d:27:1a:9f" => nrh,
        "00:30:0d:27:1a:a0" => nrh,
        "00:30:0d:27:1a:a4" => nrh,
        "00:30:0d:27:1a:ab" => nrh,
        "00:30:0d:27:1a:b5" => nrh,
        "00:30:0d:27:1a:b8" => nrh,
        "00:30:0d:27:1a:c4" => nrh,
        "00:30:0d:27:1a:cb" => nrh,
        "00:30:0d:27:1b:15" => nrh,
        "00:30:0d:27:1b:16" => nrh,
        "00:30:0d:27:1b:1a" => nrh,
        "00:30:0d:27:1b:1d" => nrh,
        "00:30:0d:27:1b:1e" => nrh,
        "FF:FF:FF:FF:FF:FF" => dtc_venue
      }

      if Merb.env == "development"
      end

      resolution = Resolution.create(:name => "Default", :height => 800, :width => 480)
      
      display_macs.each do |mac,venue|
        d = Display.create(:identifier => mac.upcase, :venue => venue, :resolution => resolution)
      end

      router_map = {
        '00:00:00:03:08:43' => gvine,
        '00:00:00:03:08:41' => lville,
        '00:00:00:03:0E:E7' => nrh,
        'FF:FF:FF:FF:FF:FF' => dtc_venue
      }

      router_map.each do |mac, venue|
        r = Router.create(:identifier => mac, :venue => venue)
        puts "#{r.identifier} #{r.venue.name} #{r.errors.join(',')}"
      end

      c = Corporation.first(:name => "Integer", :advertiser => true)
      p = Price.create(:feature_title => 'Links per Page', :amount => 0.1, :name => 'link_price')
      Discount.create(:amount => 0, :price => p, :corporation => c)

      p = Price.create(:feature_title => 'AB Test', :amount => 2.0, :name => 'ab_test_price')
      Discount.create(:amount => 0.1, :price => p, :corporation => c)
      
      p = Price.create(:feature_title => 'Flat Image Ad', :amount => 1.0, :name => :advertisement)
      Discount.create(:amount => 0.5, :price => p, :corporation => c)


      puts "Generating Hooters Pages"
      hooters_common_ads = [
        {:name => "1-APPMENU.png",
         :content_type => :flat,
         :links => [{:name => "2-BonelessWings.png", :content_type => :flat, :top => 110, :left => 279, :height => 181, :width=> 184, :links => []},
                    {:name => "3-Fried-Pickles.png", :content_type => :flat, :top => 299, :left => 277, :height => 182, :width=> 188, :links => []},
                    {:name => "4-Sampler.png", :content_type => :flat, :top => 488, :left => 275, :height => 182, :width=> 190, :links => []}]},
        {:name => "5-Lineup.png",
         :content_type => :flat, 
         :links => [{:name => "6-BuffChicks.png", :content_type => :flat, :top => 110, :left => 278, :height => 182, :width=> 190, :links => []},
                    {:name => "7-Split-Ribs.png", :content_type => :flat, :top => 296, :left => 277, :height => 185, :width=> 190, :links => []},
                    {:name => "8-TrainingBurgers.png", :content_type => :flat, :top => 485, :left => 276, :height => 182, :width=> 190, :links => []}]},
        {:name => "18-CalendarTour.png", :content_type => :flat, :links => []},
        {:name => "19-Merchandise.png",
         :content_type => :flat, 
         :links => [{:name => "20-LogoTee.png", :content_type => :flat, :top => 122, :left => 285, :height => 176, :width=> 177, :links => []},
                    {:name => "21-Calendar.png", :content_type => :flat, :top => 308, :left => 287, :height => 174, :width=> 174, :links => []},
                    {:name => "22-Koozie.png", :content_type => :flat, :top => 490, :left => 288, :height => 173, :width=> 170, :links => []}]},
        {:name => "25-FromTheBar.png",
         :content_type => :flat, 
         :links => [{:name => "152-HulaHoopPC.png", :content_type => :flat, :top => 110, :left => 281, :height => 186, :width=> 184, :links => []},
                    {:name => "153-BloodyMary.png", :content_type => :flat, :top => 299, :left => 282, :height => 182, :width=> 185, :links => []},
                    {:name => "154-Margarita.png", :content_type => :flat, :top => 486, :left => 282, :height => 184, :width=> 185, :links => []}]},
        {:name => "29-GiftCard.png", :content_type => :flat, :links => []},
        {:name => "30-BirthdayClub1b.png",
         :content_type => :flat, 
         :links => [{:name => "31-BirthdayClub2.png",
                     :content_type => :input, :top => 453, :left => 236, :height => 202, :width=> 213,
                     :survey => [
                        {:order => 1,
                         :question => "First Name",
                         :choice_type => "text",
                         :choices => [],
                         :correct_answer => ""},
                        {:order => 2,
                         :question => "Last Name",
                         :choice_type => "text",
                         :choices => [],
                         :correct_answer => ""},
                        {:order => 3,
                         :question => "Email Address",
                         :choice_type => "email",
                         :choices => [],
                         :correct_answer => ""},
                        {:order => 4,
                         :question => "Birthday",
                         :choice_type => "date",
                         :choices => [],
                         :correct_answer => ""}],
                     :links => []}]},
        {:name => "32-CustomerFeedback.png",
         :content_type => :input, 
         :links => [],
         :survey => [
            {:order => 1,
             :question => "How was your service today?",
             :choice_type => "radio",
             :choices => ["Excellent", "Good", "Bellow Average", "Poor"],
             :correct_answer => ""},
            {:order => 2,
             :question => "How was your food today?",
             :choice_type => "radio",
             :choices => ["Excellent", "Good", "Bellow Average", "Poor"],
             :correct_answer => ""},
            {:order => 3,
             :question => "Will you recommend this Hooters location to friends?",
             :choice_type => "radio",
             :choices => ["Yes", "No"],
             :correct_answer => ""}
         ]},
        {:name => "39-Desserts2.png",
         :content_type => :flat, 
         :links => [{:name => "40-DessertsChocCake.png", :content_type => :flat, :top => 109, :left => 278, :height => 180, :width=> 188, :links => []},
                    {:name => "41-DessertsKeyLimePie.png", :content_type => :flat, :top => 296, :left => 276, :height => 186, :width=> 194, :links => []},
                    {:name => "42-DessertsCheeseCake.png", :content_type => :flat, :top => 487, :left => 280, :height => 181, :width=> 186, :links => []}]},
        {:name => "110-Calendar-ad.png", :content_type => :flat, :links => []},
        {:name => "121-2008_Holiday_TT.jpg", :content_type => :flat, :links => []}
      ]

      hooters_lville_ads = []
      hooters_nrh_ads = []
      
      hooters_gvine_ads = [
        {:name => "13-HappyHourSpecials.png",
         :content_type => :flat, 
         :links => [{:name => "135-PintHappyHour.png", :content_type => :flat, :top => 263, :left => 13, :height => 162, :width=> 162, :links => []},
                    {:name => "137-PintWedHappyHour.png", :content_type => :flat, :top => 430, :left => 11, :height => 157, :width=> 162, :links => []},
                    {:name => "138-BottleHappyHour.png", :content_type => :flat, :top => 430, :left => 180, :height => 163, :width=> 162, :links => []},
                    {:name => "144-MargaritaHappyHour.png", :content_type => :flat, :top => 264, :left => 182, :height => 159, :width=> 160, :links => []}]},
        {:name => "53-Grapevinegirls.png",
         :content_type => :flat,
         :links => [{:name => "54-voteAmber.png", :content_type => :flat, :top => 119, :left => 17, :height => 247, :width=> 267,
                     :links => [{:name => "55-ThanksvoteAmber.png", :content_type => :flat, :top => 594, :left => 130, :height => 109, :width=> 211, :links => []}]},
                    {:name => "56-voteAriele.png", :content_type => :flat, :top => 372, :left => 199, :height => 256, :width=> 269,
                     :links => [{:name => "57-ThanksvoteAriele.png", :content_type => :flat, :top => 608, :left => 147, :height => 92, :width=> 182, :links => []}]}]},
      ]
      integer_common_ads =[
        {:name => "23-BlueMoon1-.png",
         :content_type => :flat, 
         :links => [{:name => "24-BlueMoon2-.png", :content_type => :flat, :top => 554, :left => 353, :height => 102, :width=> 103, :links => []}]},
        {:name => "87-invincible.jpg", :content_type => :flat, :links => []},
        {:name => "114-DrPepper2.png",
         :content_type => :flat, 
         :links => [{:name => "115-DrPepper3.png", :content_type => :flat, :top => 600, :left => 290, :height => 90, :width=> 188, :links => []}]},
        {:name => "122-TT_CAB.jpg",
         :content_type => :flat, 
         :links => [{:name => "146-nfl_schedule_13.jpg", :content_type => :flat, :top => 518, :left => 233, :height => 82, :width=> 195,
                     :links => [{:name => "147-team_standings_13.jpg", :content_type => :flat, :top => 511, :left => 244, :height => 82, :width=> 174, :links => []}]}]},
        {:name => "125-TT_GAMEDAY.jpg",
         :content_type => :flat, 
         :links => [{:name => "146-nfl_schedule_13.jpg", :content_type => :flat, :top => 518, :left => 233, :height => 82, :width=> 195,
                     :links => [{:name => "147-team_standings_13.jpg", :content_type => :flat, :top => 511, :left => 244, :height => 82, :width=> 174, :links => []}]}]},
        {:name => "128-TT_KICKOFF.jpg",
         :content_type => :flat, 
         :links => [{:name => "146-nfl_schedule_13.jpg", :content_type => :flat, :top => 518, :left => 233, :height => 82, :width=> 195,
                     :links => [{:name => "147-team_standings_13.jpg", :content_type => :flat, :top => 511, :left => 244, :height => 82, :width=> 174, :links => []}]}]},
        {:name => "79-question.jpg",
         :content_type => :flat, 
         :links => [{:name => "80-answer.jpg", :content_type => :flat, :top => 436, :left => 2, :height => 150, :width=> 299, :links => []}]},
        {:name => "84-teams.jpg",
         :content_type => :flat, 
         :links => [{:name => "85-voted.jpg", :content_type => :flat, :top => 200, :left => 28, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 200, :left => 137, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 200, :left => 243, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 200, :left => 350, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 250, :left => 28, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 250, :left => 137, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 250, :left => 243, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 250, :left => 350, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 300, :left => 28, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 300, :left => 137, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 300, :left => 243, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 300, :left => 350, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 350, :left => 28, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 350, :left => 137, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 350, :left => 243, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 350, :left => 350, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 400, :left => 28, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 400, :left => 137, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 400, :left => 243, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 400, :left => 350, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 450, :left => 28, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 450, :left => 137, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 450, :left => 243, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 450, :left => 350, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 500, :left => 28, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 500, :left => 137, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 500, :left => 243, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 500, :left => 350, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 550, :left => 28, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 550, :left => 137, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 550, :left => 243, :height => 50, :width=> 100, :links => []},
                    {:name => "85-voted.jpg", :content_type => :flat, :top => 550, :left => 350, :height => 50, :width=> 100, :links => []}
         ]},
      ]
      integer_gvine_ads = [
        {:name => "133-TT_OFFER3_Grapevine.jpg", :content_type => :flat, :links => []}
      ]
      
      start_date = Time.gm(2008, "nov", 3)
      puts "Generating Hooters Common Campaign"
      campaign(:name => "Hooters Common Campaign", :exec => wot_admin, :corporation => vencorp) do |c|
        assign_campaign(c) do |c|
          c.publish_groups << publish_group(:name => "All Texas", :user => wot_admin) do |pg|
            pg.state_assignments << StateAssignment.create(:included => true, :state => State.first(:code => "TX"), :publish_group => pg)
          end
        end

        populate_campaign(c) do |c|
          hooters_common_ads.each do |a|
            ci = ContentItem.create(:name => a[:name], :layout => :full, :resolution => resolution)
            ci.pages << create_page(c.exec, Merb.root / :assets / :images / :hooters_common_ads, a[:name], a[:links], a[:survey], a[:content_type])
            ci.save
            raise "Error on ContentItem.create: #{u.errors}" unless ci.valid?
            c.content_items << ci
          end
        end

        schedule_campaign(c) do |c|
          v = VenueContract.create(:price => 0.0, :start_at => start_date, :end_at => start_date + 1.year, :campaign => c)
          c.contracts << v
          v.approve
        end
      end

      puts "Generating Hooters Grapevine Campaign"
      campaign(:name => "Hooters Grapevine Campaign", :exec => wot_admin, :corporation => vencorp) do |c|
        assign_campaign(c) do |c|
          pg = publish_group(:name => "Grapevine", :user => wot_admin)
          c.publish_groups << pg
          va = VenueAssignment.create(:included => true, :venue => gvine, :publish_group => pg)
        end

        populate_campaign(c) do |c|
          hooters_gvine_ads.each do |a|
            ci = ContentItem.create(:name => a[:name], :layout => :full, :resolution => resolution)
            ci.pages << create_page(c.exec, Merb.root / :assets / :images / :hooters_grapevine_ads, a[:name], a[:links], a[:survey], a[:content_type])
            ci.save
            raise "Error on ContentItem.create: #{u.errors}" unless ci.valid?
            c.content_items << ci
          end
        end

        schedule_campaign(c) do |c|
          v = VenueContract.create(:price => 0.0, :start_at => start_date, :end_at => start_date + 1.year, :campaign => c)
          c.contracts << v
          v.approve
        end
      end

      puts "Generating Integer Common Hooters Campaign"
      campaign(:name => "Integer Common Hooters Campaign", :exec => integer_admin, :corporation => integer_corp) do |c|
        assign_campaign(c) do |c|
          c.publish_groups << publish_group(:name => "All Texas", :user => integer_admin) do |pg|
            pg.state_assignments << StateAssignment.create(:included => true, :state => State.first(:code => "TX"), :publish_group => pg)
          end
        end

        populate_campaign(c) do |c|
          integer_common_ads.each do |a|
            ci = ContentItem.create(:name => a[:name], :layout => :full, :resolution => resolution)
            ci.pages << create_page(c.exec, Merb.root / :assets / :images / :integer_common_ads, a[:name], a[:links], a[:survey], a[:content_type])
            ci.save
            raise "Error on ContentItem.create: #{u.errors}" unless ci.valid?
            c.content_items << ci
          end
        end

        schedule_campaign(c) do |c|
          v = VenueContract.create(:price => 10.00, :start_at => start_date, :end_at => start_date + 1.year, :campaign => c)
          c.contracts << v
          v.approve
        end
      end

      puts "Generating Integer Grapevine Hooters Campaign"
      campaign(:name => "Integer Grapevine Hooters Campaign", :exec => integer_admin, :corporation => integer_corp) do |c|
        assign_campaign(c) do |c|
          pg = publish_group(:name => "Grapevine", :user => integer_admin)
          c.publish_groups << pg
          va = VenueAssignment.create(:included => true, :venue => gvine, :publish_group => pg)
        end

        populate_campaign(c) do |c|
          integer_gvine_ads.each do |a|
            ci = ContentItem.create(:name => a[:name], :layout => :full, :resolution => resolution)
            ci.pages << create_page(c.exec, Merb.root / :assets / :images / :integer_grapevine_ads, a[:name], a[:links], a[:survey], a[:content_type])
            ci.save
            raise "Error on ContentItem.create: #{u.errors}" unless ci.valid?
            c.content_items << ci
          end
        end

        schedule_campaign(c) do |c|
          v = VenueContract.create(:price => 10.00, :start_at => start_date, :end_at => start_date + 1.year, :campaign => c)
          c.contracts << v
          v.approve
        end
      end

      puts "Generating Base Deployment"
      u = User.first(:email => "aaron@downtowncartel.com")
      menu = Menu.create(:root => true, :title => "Home")
      campaign = Campaign.create(:exec => u, :name => "DP Deployment Base", :corporation => dtc)
      contract = Contract.create(:price => 0.0, :start_at => Time.now, :end_at => Time.now + 1.year, :campaign => campaign)
      contract.approve()
      pg = PublishGroup.create(:user => u, :name => "DP Deployment Base")
      sa = StateAssignment.create(:included => true, :state => State.first(:code => "TX"), :publish_group => pg)
      db = DeployBase.create(:name => "DP Deployment Base", :deploy_path => "/tmp/dp", :contract => contract, :publish_group => pg, :menu => menu)

      puts "Creating RPMs"
      create_rpm(Merb.root / :assets / :rpms, "displaypoints-98.0_beta-1.noarch.rpm", 98, 0, "beta", 1)
      create_rpm(Merb.root / :assets / :rpms, "displaypoints-98.0_final-1.noarch.rpm", 98, 0, "final", 1)
      create_rpm(Merb.root / :assets / :rpms, "displaypoints-99.0_final-1.noarch.rpm", 99, 0, "final", 1)

  end
end

def setup_campaign(campaign, ad_set, path, user, resolution)
  ad_set.each do |pinfo|
    p = create_page(user, path, pinfo[:name], pinfo[:links], pinfo[:survey], pinfo[:content_type])
    ci = ContentItem.create(:name => pinfo[:name], :layout => :full, :resolution => resolution)
    ci.pages << p
    ci.save
    campaign.content_items << ci
    campaign.save
  end
end


def corporation(klass = Corporation, attributes = {})
  klass, attributes = Corporation, klass if klass.is_a? Hash 
  c = klass.create(attributes)
  raise "Error on #{klass.name}.create: #{c.errors.map{|e| e.to_s}.join(', ')}" unless c.valid?
  yield c if block_given?

  c
end

def user(attributes = {})
  u = User.create(attributes)
  raise "Error on User.create: #{u.errors}" unless u.valid?
  yield u if block_given?

  u.activate!
  raise "Error on User#activate!: #{u.errors}" unless u.valid?

  u
end

def role(attributes = {})
  r = CorpRole.create(attributes)
  raise "Error on CorpRole.create: #{r.errors}" unless r.valid?
  yield r if block_given?

  r
end

def campaign(attributes = {})
  c = Campaign.create(attributes)
  raise "Error on Campaign.create: #{c.errors}" unless c.valid?
  yield c if block_given?

  c
end

def publish_group(attributes = {})
  pc = PublishGroup.create(attributes)
  raise "Error on PublishGroup.create: #{pc.errors}" unless pc.valid?
  yield pc if block_given?

  pc
end

def assign_campaign(c)
  yield c if block_given?

  c.assign!

  raise "Error on Campaign#assign!: #{c.errors}" unless c.valid?

  c
end

def populate_campaign(c)
  raise "Error, campaign is not assigned: #{c}" unless c.assigned?

  yield c if block_given?

  c.populate!

  raise "Error on Campaign#populate!: #{c.errors}" unless c.valid?

  c
end

def schedule_campaign(c)
  raise "Error, campaign is not populated: #{c}" unless c.populated?

  yield c if block_given?

  c.schedule!
  
  raise "Error on Campaign#schedule: #{c.errors}"unless c.valid?

  c
end

def recur_new_page(user, media_path, parent, link_info)
  l = Link.new(:x_coord => link_info[:left], 
               :y_coord => link_info[:top],
               :width => link_info[:width], 
               :height => link_info[:height],
               :source_page => parent,
               :current_user => user)
  l.dest_attrs = {:parent => parent, :content_type => link_info[:content_type], :media_data => tmp_media_data(media_path / link_info[:name])}
  l.save

  create_survey(l.destination_page, link_info[:survey]) unless link_info[:survey] == nil

  link_info[:links].each do |link_info|
    recur_new_page(user, media_path, l.destination_page, link_info)
  end
end

def create_page(user, media_path, name, links, survey, content_type)
  page = Page.create(:parent => nil, :user => user, :content_type => content_type, :media_data => tmp_media_data("#{media_path}/#{name}"))
  create_survey(page, survey) unless survey == nil

  links.each do |link_info|
    recur_new_page(user, media_path, page, link_info)
  end
  return page
end

def create_survey(page, survey_data)
    s = page.survey
    survey_data.each do |inq_data|
      i = Inquiry.create(:question => inq_data[:question],
                         :answer => inq_data[:answer],
                         :type => inq_data[:choice_type],
                         :choices => inq_data[:choices],
                         :order => inq_data[:order])
      s.inquiries << i
    end
    s.save
end

def create_rpm(media_path, filename, major, minor, rname, rcode)
  rpm = Rpm.create(:major_version => major,
                   :minor_version => minor,
                   :release_name => rname,
                   :release_code => rcode,
                   :media_data => tmp_media_data("#{media_path}/#{filename}"))
end

def tmp_media_data(file)
  tmp = Tempfile.new(File.basename(file))
  tmp.close
  FileUtils.cp file, tmp.path
 
  type = case File.extname(file)
  when '.png' then "image/png"
  when '.jpeg', '.jpg' then "image/jpeg"
  when '.rpm' then 'application/x-rpm'
  end
 
  Mash.new(:tempfile => tmp, :filename => File.basename(file), :content_type => type)
end
