require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Campaign do
  describe "Validation:" do
    describe :given => "an initiated campaign => @campaign" do
      it "should require the corporation match the exec's corporation" do
        pending "FUCKING DM"
        @campaign.should be_valid
        @campaign.exec.corp_role.corporation = Corporation.gen
        @campaign.exec.save && @campaign.reload
        @campaign.exec.corporation.should_not == @campaign.corporation
        @campaign.should_not be_valid
      end

      it "should require the exec to be an admin" do
        @campaign.should be_valid
        @campaign.exec = User.gen(:corp_role => CorpRole.make(:corporation => @campaign.corporation))
        @campaign.exec.should_not be_admin
        @campaign.should_not be_valid
      end

      describe "name" do
        it "should be present" do
          pending
        end
      end

      describe "exec" do
        it "should be present" do
          pending
        end
      end
    end
  end

  %w[files filelist].each do |method| #filelist is an alias to files
    describe "##{method}", :given => "an empty item campaign => @empty_item_campaign" do

      it "should be empty" do
        @empty_item_campaign.send(method).should be_empty
      end
    end

    describe "##{method}", :given => "a campaign with files => @campaign" do
      it "should include it's content_items' files" do
        @campaign.content_items.each do |ci|
          @campaign.send(method).should include(*ci.files)
        end
      end
    end
  end

  describe "#venues" do
    it do
      pending "HACK"
    end
  end

  describe "#purpose", :given => "an add campaign => @ad_campaign" do
    it "should return 'ad'" do
      @ad_campaign.purpose.should == 'ad'
    end
  end

  describe "#purpose", :given => "a content campaign => @content_campaign" do
    it "should return 'content'" do
      @content_campaign.purpose.should == 'content'
    end
  end

  describe "#price_per_day" do
    it do
      pending "HACK"
    end
  end

  describe "#serialize" do
    it do
      pending "MOVE TO #to_hash"
    end
  end

  describe "#to_mash", :given => "a campaign => @campaign" do
    it "should include the id" do
      @campaign.to_mash[:id].should == @campaign.id
    end

    it "should include the name" do
      @campaign.to_mash[:name].should == @campaign.name
    end

    it "should not include the content items unless specified" do
      @campaign.to_mash.should_not have_key(:content_items)
    end

    it "should include the content items if specified" do
      pending "ContentItem#to_mash"
      @campaign.to_mash[:content_items].should == @campaign.content_items.map {|ci| ci.to_mash}
    end

    it "should not include the publish group unless specified" do
      @campaign.to_hash.should_not have_key(:publish_groups)
    end

    it "should include the content items if specified" do
      pending "PublishGroup#to_mash"
      @campaign.to_mash[:publish_groups].should == @campaign.publish_groups.map {|pg| pg.to_mash}
    end

    it "should not include the campaign assignments unless specified" do
      @campaign.to_hash.should_not have_key(:campaign_assignments)
    end

    it "should include the content items if specified" do
      pending "CampaignAssignment#to_mash"
      @campaign.to_mash[:campaign_assignments].should == @campaign.campaign_assignments.map {|ci| ci.to_mash}
    end

    it "should not include the users unless specified" do
      @campaign.to_hash.should_not have_key(:users)
    end

    it "should include the content items if specified" do
      pending "User#to_mash"
      @campaign.to_mash[:users].should == @campaign.users.map {|u| u.to_mash}
    end
  end
end