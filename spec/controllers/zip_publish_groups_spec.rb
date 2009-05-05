require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe ZipPublishGroups, "index action" do
  before(:each) do
    dispatch_to(ZipPublishGroups, :index)
  end
end