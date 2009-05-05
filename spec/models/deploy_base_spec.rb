require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe DeployBase do

  describe :given => 'a deploy base => @deploy_base' do
    describe "#filenames" do
      it "should contain all the menu's filesnames" do
        pending "LOGIC ERROR"
        @deploy_base.filenames.should include(@deploy_base.menu.filenames)
      end

      it "should contain all the campaign's filesnames" do
        pending "LOGIC ERROR"
        @deploy_base.filenames.should include(@deploy_base.campaign.filenames)
      end
    end

    describe "#json" do
      it '' do
        pending "MOVE TO #to_json"
      end

      it '' do
        pending "HACK"
      end
    end

    describe "#menu_json" do
      it '' do
        pending "HACK"
      end
    end

    describe "#campaign_json" do
      it '' do
        pending "HACK"
      end
    end
  end
end