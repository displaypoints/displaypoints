require File.join( File.dirname(__FILE__), "..", "..", "spec_helper" )

describe Asset do
  describe "Named Scope:" do
    it "available" do
      pending
    end

    it "inuse" do
      pending
    end

    it "all_for_user" do
      pending "HACK"
    end
  end

  describe "Validation:" do
    describe "identifier" do
      it "should be present" do
        pending
      end
    end

    describe "slug" do
      it "should be present" do
        pending
      end
    end
  end

  describe "#available?", :given => "an unassociated asset => @unassoc" do
    it "should return true" do
      @unassoc.should be_available
    end
  end

  describe "#available?", :given => "an associated asset => @assoc" do
    it "should return false" do
      @assoc.should_not be_available
    end
  end

  describe "#inuse?", :given => "an associated asset => @assoc" do
    it "should return true" do
      @assoc.should be_inuse
    end
  end

  describe "#inuse?", :given => "an unassociated asset => @unassoc" do
    it "should return false" do
      @unassoc.should_not be_inuse
    end
  end

  describe "#to_hash", :given => "an asset => @asset" do
    it "should include the id" do
      @asset.to_hash[:id].should == @asset.id
    end

    it "should include the asset type" do
      @asset.to_hash[:type].should == @asset.type
    end

    it "should include the identifier" do
      @asset.to_hash[:identifier].should == @asset.identifier
    end

    it "should include the slug" do
      @asset.to_hash[:slug].should == @asset.slug
    end

    it "should not include the venue" do
      @asset.to_hash.should_not have_key(:venue)
    end
  end
end
