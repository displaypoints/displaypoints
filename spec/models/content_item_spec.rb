require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe ContentItem do

  describe "Named Scope:" do
    it "by_type" do
      pending
    end
  end

  describe "Validation:" do
    describe "content_type" do
      it "should be present" do
        pending
      end
    end

    describe "resolution" do
      it "should be present" do
        pending
      end
    end
  end

  describe "Custom Validation:", :given => "a content item => @content_item" do
    it "should have the same resolution as media" do
      @content_item.resolution = Resolution.gen(:height => @content_item.pages.first.media.height + 1, :width => @content_item.pages.first.media.width + 1)
      @content_item.should_not be_valid
    end
  end

  describe "#thumb", :given => "an advertisement item => @ad_content_item" do
    it "should be the first page's thumb" do
      @ad_content_item.thumb.should == @ad_content_item.pages.first.thumb
      true
    end
  end

  describe "#serial_attrs" do
    it '' do
      pending "HACK"
    end
  end

  describe "#recur_serialize" do
    it '' do
      pending "HACK"
    end
  end

  describe "#serialize" do
    it '' do
      pending "HACK"
    end
  end

  describe "#files", :given => "a content item with pages => @content_item" do
    it "should include it's page's files" do
      @content_item.pages.each do |page|
        @content_item.files.should include(*page.files)
      end
    end
  end

  describe "#to_mash", :given => "a content item => @content_item" do
    it "should include the id" do
      @content_item.to_mash[:id].should == @content_item.id
    end

    it "should include the name" do
      @content_item.to_mash[:name].should == @content_item.name
    end

    it "should include the layout" do
      @content_item.to_mash[:layout].should == @content_item.layout
    end

    it "should not include the tags unless specified" do
      pending "Tag#to_mash"
      @content_item.to_mash.should_not have_key(:tags)
      @content_item.to_mash(:tags => true).should have_key(:tags)
    end

    it "should not include the cron_schedules unless specified" do
      @content_item.to_mash.should_not have_key(:cron_schedules)
      @content_item.to_mash(:cron_schedules => true).should have_key(:cron_schedules)
    end

    it "should not include the resolutions unless specified" do
      @content_item.to_mash.should_not have_key(:resolution)
      @content_item.to_mash(:resolution => true).should have_key(:resolution)
    end
  end
end