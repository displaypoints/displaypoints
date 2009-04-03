require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe CronSchedule do
  describe :given => 'a cron schedule => @cron_schedule' do
    describe "#to_s" do
      it "should be in cron format (* * * * *)" do
        @cron_schedule.to_s.should =~ /(([0-9]*|\*)\s){4}([0-9]*|\*)/
      end
    end
  end
end