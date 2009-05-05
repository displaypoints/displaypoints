require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec_helper')

describe 'campaigns controller', :given => 'an authenticated user => @user' do
  before(:all) do
    5.times{ Campaign.gen(:venue) }
  end
  
  describe 'GET url(:campaigns)' do
    before do
      @response = request(url(:campaigns))
    end

    it_should_behave_like 'It is successful'
  end

  describe 'POST url(:campaigns)' do
  end

  describe 'GET url(:new_campaign)' do
    before do
      @response = request(url(:new_campaign))
    end

    it_should_behave_like 'It is successful'
  end

  describe 'GET url(:edit_campaign)' do
  end

  describe 'PUT url(:campaign)' do
  end

  describe 'GET url(:campaign,@campaign)' do
  end
end
