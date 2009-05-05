require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe CorpRole do

  describe "Validation:" do
    describe "corporation" do
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

  describe :given => "an admin CorpRole => @admin_corp_role" do
    describe "#admin!" do
      it "should not do anything" do
        lambda { @admin_corp_role.admin! }.should_not change { @admin_corp_role.admin? }
      end
    end

    describe "#user!" do
      it "should change from an admin to a user" do
        lambda { @admin_corp_role.user! }.should change { @admin_corp_role.admin? }.from(true).to(false)
      end
    end

    describe "#admin?" do
      it "should be true" do
        @admin_corp_role.should be_admin
      end
    end

    describe "#root?" do
      it "should be false" do
        @admin_corp_role.should_not be_root
      end
    end
  end

  describe :given => "a normal CorpRole => @corp_role" do
    describe "#admin!" do
      it "should change from false to true" do
        lambda { @corp_role.admin! }.should change { @corp_role.admin? }.from(false).to(true)
      end
    end

    describe "#user!" do
      it "should not do anything" do
        lambda { @corp_role.user! }.should_not change { @corp_role.admin? }
      end
    end

    describe "#admin?" do
      it "should be false" do
        @corp_role.should_not be_admin
      end
    end

    describe "#root?" do
      it "should be false" do
        @corp_role.should_not be_root
      end
    end
  end

  describe "#root?", :given => "a root CorpRole => @root_role" do
    it "should be true" do
      @root_role.should be_root
    end
  end

  describe "#users" do
    it '' do
      pending "SMELL"
    end
  end

  describe "#campaigns" do
    it '' do
      pending "SMELL"
    end
  end
end