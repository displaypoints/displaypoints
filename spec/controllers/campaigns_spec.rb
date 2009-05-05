require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Campaigns, "index action" do

  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:campaigns)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:campaigns))

      response.should be_successful
    end
  end
end

describe Campaigns, "new action" do
  it '' do
    pending "SMELL"
  end
end

describe Campaigns, "create action", :given => "an unsaved campaign => @campaign" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { post(url(:campaigns)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      pending "Campaign#to_h"
      response = request(url(:campaigns), :method => "POST", params => {:campaign => @campaign.to_h})

      response.should redirect_to(url(:campaign, @campaign))
    end
  end
end

describe Campaigns, "show action", :given => "an empty campaign => @campaign" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:campaign, @campaign)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:campaign, @campaign))

      response.should be_successful
    end
  end
end

describe Campaigns, "edit action", :given => "an empty campaign => @campaign" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:edit_campaign, @campaign)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:edit_campaign, @campaign))

      response.should be_successful
    end
  end
end

describe Campaigns, "update action", :given => "an empty campaign => @campaign" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { put(url(:campaign, @campaign)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should redirect to the Campaigns show view" do
      pending "Campaign#to_h"
      response = request(url(:campaign, @campaign), :method => "PUT", :params => {:campaign => @campaign.to_h})

      response.should redirect_to(url(:campaign, @campaign))
    end
  end
end

describe Campaigns, "new_content action" do
  it '' do
    pending "SMELL"
  end
end

describe Campaigns, "add_content action" do
  it '' do
    pending "SMELL"
  end
end