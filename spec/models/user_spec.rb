require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe User do

  describe "Validation:" do
    describe :given => "an initiated user => @user" do
      it "should not require a corp_role" do
        @user.corp_role = nil
        @user.should be_valid
      end
    end

    describe :given => "an activated user => @user" do
      it "should require a corp_role" do
        @user.corp_role = nil
        @user.should_not be_valid
      end
    end

    describe "email" do
      it "should be present" do
        pending
      end

      it "should be formatted correctly" do
        pending
      end
    end

    describe "corporation" do
      it "should be present" do
        pending
      end
    end

    describe "password" do
      it "should be confirmed" do
        pending
      end
    end
  end

  describe ".create_with_role" do
    it '' do
      pending "HACK"
    end
  end

  describe "#update_with_role" do
    it '' do
      pending "HACK"
    end
  end

  describe "#pages" do
    it '' do
      pending "SMELL"
    end
  end

  describe "#corp_role" do
    it '' do
      pending "HACK"
    end
  end

  describe "#all_campaigns" do
    it '' do
      pending "SMELL"
    end
  end

  describe :given => "a root user => @root_user" do
    describe "#admin?" do
      it "should be true" do
        @root_user.should be_admin
      end
    end

    describe "#root?" do
      it "should be true" do
        @root_user.should be_root
      end
    end
  end

  describe :given => "an admin user => @admin" do
    describe "#admin?" do
      it "should be true" do
        @admin.should be_admin
      end
    end

    describe "#root?" do
      it "should be false" do
        pending "HACK"
        @admin.should_not be_root
      end
    end
  end

  describe :given => "a regular user => @user" do
    describe "#admin?" do
      it "should be false" do
        @user.should_not be_admin
      end
    end

    describe "#root?" do
      it "should be false" do
        pending "HACK"
        @user.should_not be_root
      end
    end
  end
end
