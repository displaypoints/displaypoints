require File.join( File.dirname(__FILE__), "..", "..", "spec_helper" )

describe Router do

  describe "Validation:" do
    describe "identifier" do
      it "should be well formatted" do
        pending
      end
    end
  end

  describe "Custom Validation:" do
    describe :given => "an inuse router => @router" do
      it "should not be assaigned to an occupied venue" do
        pending "FUCKING DATAMAPPER"

        router = Router.make(:venue => @router.venue)
        @router.venue.router = @router

        router.save.should be_false
        router.errors.should_not be_empty
      end
    end
  end
end