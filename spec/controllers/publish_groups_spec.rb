require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe PublishGroups, "index action", :given => "multiple publish groups => @publish_groups" do

  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:publish_groups)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:publish_groups))

      response.should be_successful
    end

    it "should render all the publish groups in the #publish_group table" do
      response = request(url(:publish_groups))
      response.should have_selector("table#publish_groups")

      pending "SEMANTIC MARKUP"
      @publish_groups.each do |pg|
        #response.should have_selector(...)
      end
    end
  end

  describe "JSON" do
    it '' do
      pending
    end
  end
end

describe PublishGroups, "show action", :given => "a publish group with many assignments => @publish_group" do

  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:publish_group, @publish_group)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:publish_group, @publish_group))

      response.should be_successful
    end

    it "should be semantic" do
      pending
    end
  end
end

describe PublishGroups, "new action" do

  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:new_publish_group)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:new_publish_group))

      response.should be_successful
    end
  end
end

describe PublishGroups, "create action", :given => "an unsaved publish group => @publish_group" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { post(url(:new_publish_group)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should redirect to the PublishGroups show action" do
      pending "PublishGroup#to_h"
      response = request(url(:new_publish_group), :method => "POST", :publish_group => @publish_group.to_h)

      response.should redirect_to(url(:publish_group, @publish_group))
    end
  end
end

describe PublishGroups do
  describe "#find_children" do
    it '' do
      pending "HACK"
    end
  end
end