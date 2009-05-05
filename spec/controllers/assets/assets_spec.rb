require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Assets, "index action" do

  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:assets)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:assets))

      response.should be_successful
    end

    it "should include the chargers" do
      pending "more semantic markup"
      response = request(url(:assets))
      Charger.all_for_user(@user).each do |charger|
        #response.should have_selector
      end
    end

    it "should include the displays" do
      pending "more semantic markup"
      response = request(url(:assets))
      Display.all_for_user(@user).each do |display|
        #response.should have_selector
      end
    end

    it "should include the routers" do
      pending "more semantic markup"
      response = request(url(:assets))
      Router.all_for_user(@user).each do |router|
        #response.should have_selector
      end
    end

    it "should render the asset's status" do
      pending "more semantic markup"
      response = request(url(:assets))
      available = Asset.all_for_user(@user).available.first
      inuse = Asset.all_for_user(@user).inuse.first
      #response.should have_selector
    end
  end
end

describe Assets, "new action" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:new_asset)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:new_asset))
      
      response.should be_successful
    end
  end
end

describe Assets, "create action" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      pending "Asset#to_h"

      asset = [Charger, Display, Router].pick.make
      lambda { post(url(:assets, :asset => asset.to_h)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      pending "Asset#to_h"

      asset = [Charger, Display, Router].pick.make
      response = request(url(:assets, :method => "POST", :params => {:asset => asset.to_h}))
      
      response.should be_successful
    end
  end
end