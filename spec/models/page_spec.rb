require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Page do

  describe "Named Scope:" do
    it "all_root_for_user" do
      pending "HACK"
    end

    it "all_for_user" do
      pending "HACK"
    end

    it "child_pages" do
      pending
    end
  end

  describe "Validation:" do
    describe "node" do
      it "should be present" do
        pending
      end
    end

    describe "user" do
      it "should be present" do
        pending
      end
    end
  end

  describe "Custom Validation:" do
    describe "#referential_paradox", :given => "a self referential page => @page" do
      it "should not be valid" do
        @page.destination_pages.should include(@page)
        @page.should_not be_valid
      end
    end
  end

  describe :given => "sibling pages => @first_page, @second_page" do
    it "should share the same parent" do
      @first_page.parent.should == @second_page.parent
    end
  end

  describe :given => "a root page => @root_page" do
    describe "#root?" do
      it "should be true" do
        @root_page.should be_root
      end
    end
  end

  describe :given => "a zero depth child page => @child_page" do
    describe "#root?" do
      it "should be false" do
        @child_page.should_not be_root
      end
    end
  end

  describe "#files", :given => "a page with outgoing links => @page" do
    it "should include the page media's full_path" do
      @page.files.should include(@page.media.full_path)
    end

    it "should include any destination page's files" do
      @page.destination_pages.each do |dp|
        dp.files.each do |f|
          @page.files.should include(f)
        end
      end
    end
  end

  describe "#to_mash", :given => "a page => @page" do
    it "should include the id" do
      @page.to_mash[:id].should == @page.id
    end

    it "should include the token" do
      @page.to_mash[:token].should == @page.token
    end

    it "should include the content_url" do
      @page.to_mash[:content_url].should == @page.content_url
    end

    it "should include the content_url" do
      @page.to_mash[:content_type].should == @page.content_type
    end

    it "should not include the media unless specified" do
      pending "Upload#to_mash"
      @page.to_mash.should_not have_key(:media)
      @page.to_mash(:media => true).should have_key(:media)
    end

    it "should not include the thumb unless specified" do
      pending "Upload#to_mash"
      @page.to_mash.should_not have_key(:thumb)
      @page.to_mash(:thumb => true).should have_key(:thumb)
    end

    it "should not include the survey unless specified" do
      pending "Suervey#to_mash"
      @page.to_mash.should_not have_key(:survey)
      @page.to_mash(:survey => true).should have_key(:survey)
    end
  end

  describe "#to_mash", :given => "a page with outgoing links => @page" do
    it "should not include the outgoing links unless specified" do
      pending "Link#to_mash"
      @page.to_mash.should_not have_key(:outgoing_links)
      @page.to_mash(:outgoing_links => true).should have_key(:outgoing_links)
    end

    it "should not include the destination pages unless specified" do
      @page.to_mash.should_not have_key(:destination_pages)
      @page.to_mash(:destination_pages => true).should have_key(:destination_pages)
    end
  end

  describe "#to_mash", :given => "a page with incoming links => @page" do
    it "should not include the outgoing links unless specified" do
      pending "Link#to_mash"
      @page.to_mash.should_not have_key(:incoming_links)
      @page.to_mash(:incoming_links => true).should have_key(:incoming_links)
    end

    it "should not include the source pages unless specified" do
      @page.to_mash.should_not have_key(:source_pages)
      @page.to_mash(:source_pages => true).should have_key(:source_pages)
    end
  end

  describe "#clone", :given => "a page => @page" do
    it "should not copy the id" do
      @page.clone.id.should_not == @page.id
    end
  end
end