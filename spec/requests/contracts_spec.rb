require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec_helper')

describe 'contracts controller requests', :given => "an auth'd root user => @user" do 
  describe 'GET url(:campaign_new_contract,@campaign)' do
    before do
      @campaign = Campaign.gen(:venue)
      puts @campaign.inspect
      @response = request(url(:campaign_new_contract, @campaign))
    end
  
    it_should_behave_like 'It is successful'
  end

  describe 'POST url(:campaign_add_contract,@campaign)' do
  end
end