require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe StatePublishGroups, "index action" do
  before(:each) do
    dispatch_to(StatePublishGroups, :index)
  end
end