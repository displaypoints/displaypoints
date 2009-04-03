require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Pages, "index action", :given => "multiple pages => @pages" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      lambda { get(url(:pages)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      response = request(url(:pages))

      response.should be_successful
    end
  end
end

describe Pages, "index action", :given => "a root page => @root_page" do
  describe :given => "an unauthenticated user => @user" do
    it "should raise an Unauthenticated exception" do
      pending "ROUTER MISMATCH"
      lambda { get(url(:page, @page)) }.should raise_error(Merb::Controller::Unauthenticated)
    end
  end

  describe :given => "an authenticated user => @user" do
    it "should respond successfully" do
      pending "ROUTER MISMATCH"
      response = request(url(:page, @page))

      response.should be_successful
    end
  end
end

describe Pages, "new_root action" do
  it '' do
    pending "HACK"
  end
end

describe Pages, "create_root action" do
  it '' do
    pending "HACK"
  end
end

describe Pages, "clone_root action" do
  it '' do
    pending "HACK"
  end
end

describe Pages, "new_child action" do
  it '' do
    pending "HACK"
  end
end

describe Pages, "create_child action" do
  it '' do
    pending "HACK"
  end
end