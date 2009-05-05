require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Price do

  describe "Named Scope:" do
    it "all_for_user" do
      pending "HACK"
    end
  end

  describe "#includes?" do
    it '' do
      pending "SMELL"
    end
  end

  describe :given => "a publish group with many assignments => @publish_group" do
    describe "#venue_set" do
      it "should include anything associated by an included assignment" do
        pending "TOO COMPLEX"
        @publish_group.venue_set.each do |in_set|
          @publish_group.venue_assignments.all(:included => true).map {|va| va.venue}.should include(in_set)
          @publish_group.city_assignments.all(:included => true).map {|va| va.city.venues}.flatten.should include(in_set)
          @publish_group.zipcode_assignments.all(:included => true).map {|va| va.zipcode.venues}.flatten.should include(in_set)
          @publish_group.state_assignments.all(:included => true).map {|va| va.state.venues}.flatten.should include(in_set)
        end
      end

      it "should not include anything associated by an excluded assignment" do
        pending "TOO COMPLEX"
        @publish_group.venue_set.each do |in_set|
          @publish_group.venue_assignments.all(:included => false).map {|va| va.venue}.should_not include(in_set)
          @publish_group.city_assignments.all(:included => false).map {|va| va.city.venues}.flatten.should_not include(in_set)
          @publish_group.zipcode_assignments.all(:included => false).map {|va| va.zipcode.venues}.flatten.should_not include(in_set)
          @publish_group.state_assignments.all(:included => false).map {|va| va.state.venues}.flatten.should_not include(in_set)
        end
      end
    end
  end
end