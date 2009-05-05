require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Venues, "index action", :given => "multiple venues => @venues" do

  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:venues)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      pending "HACK"
      response = request(url(:venues))

      response.should be_successful
    end
  end
end

describe Venues, "show action", :given => "a venue => @venue" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:venue, @venue)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:venue, @venue))

      response.should be_successful
    end
  end
end

describe Venues, "new action" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:new_venue)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:new_venue))

      response.should be_successful
    end
  end
end

describe Venues, "create action", :given => "an unsaved venue => @venue" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { post(url(:venues)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should redirect to the Venues show action" do
      pending "Venues#to_h"

      response = request(url(:venues), :method => "POST", :corporation => @corporation.to_h)

      response.should redirect_to(url(:venue, @venue))
    end
  end
end

describe Venues, "edit action", :given => "a venue => @venue" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:edit_venue, @venue)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:edit_venue, @venue))

      response.should be_successful
    end
  end
end

describe Venues, "update action", :given => "a venue => @venue" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { put(url(:venue, @venue)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should redirect to the Corporations show action" do
      pending "Venue#to_h"

      response = request(url(:venue, @corporation), :method => "PUT", :corporation => @venue.to_h)

      response.should redirect_to(url(:venue, @venue))
    end
  end
end

describe Venues, "destroy action" do
  it '' do
    pending "HACK"
  end
end