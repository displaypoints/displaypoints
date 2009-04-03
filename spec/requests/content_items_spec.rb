require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec_helper')

describe 'content_items controller requests', :given => "an auth'd root user => @user" do
  describe 'GET url(:campaign_new_content,@campaign)' do
    before do
      @campaign = Campaign.gen(:venue)
      @response = request(url(:campaign_new_content, @campaign))
    end
  
    it_should_behave_like 'It is successful'
  end

  describe 'POST url(:campaign_add_content,@campaign)' do
  end
end