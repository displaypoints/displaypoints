require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Corporations, "index action", :given => "multiple corporations => @corporations" do

  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:corporations)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:corporations))

      response.should be_successful
    end
  end
end

describe Corporations, "show action", :given => "a corporation => @corporation" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:corporation, @corporation)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:corporation, @corporation))

      response.should be_successful
    end
  end
end

describe Corporations, "new action" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:new_corporation)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:new_corporation))

      response.should be_successful
    end
  end
end

describe Corporations, "create action", :given => "an unsaved corporation => @corporation" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { post(url(:corporations)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should redirect to the Corporations show action" do
      pending "Corporation#to_h"

      response = request(url(:corporations), :method => "POST", :corporation => @corporation.to_h)

      response.should redirect_to(url(:corporation, @corporation))
    end
  end
end

describe Corporations, "edit action", :given => "a corporation => @corporation" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:edit_corporation, @corporation)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:edit_corporation, @corporation))

      response.should be_successful
    end
  end
end

describe Corporations, "update action", :given => "a corporation => @corporation" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { put(url(:corporation, @corporation)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should redirect to the Corporations show action" do
      pending "Corporation#to_h"

      response = request(url(:corporation, @corporation), :method => "PUT", :corporation => @corporation.to_h)

      response.should redirect_to(url(:corporation, @corporation))
    end
  end
end

describe Corporations, "destroy action" do
  it '' do
    pending "HACK"
  end
end