require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec_helper')

describe 'pages controller requests', :given => "an auth'd root user => @user" do
  describe 'GET url(:pages)' do
    before do
      @response = request(url(:pages))
    end
  
    it_should_behave_like 'It is successful'
  end

  describe 'GET url(:new_root_page)' do
    before do
      @response = request(url(:new_root_page))
    end
  
    it_should_behave_like 'It is successful'
  end

  # describe 'GET url(:new_child_page)' do
  #   before do
  #     @response = request(url(:new_child_page, Page.first))
  #   end
  # 
  #   it_should_behave_like 'It is successful'
  # end
  # 
  # describe 'GET url(:page,@page) for :flat' do
  #   before do
  #     @flat = Page.create(Page.gen_attrs(:root).merge(:content_type => :flat))
  #     @response = request(url(:page, @flat))
  #   end
  # 
  #   it_should_behave_like 'It is successful'
  # end
  # 
  # describe 'GET url(:page,@page) for :input' do
  #   before do
  #     @input = Page.create(Page.gen_attrs(:root).merge(:content_type => :input))
  #     @response = request(url(:page, @input))
  #   end
  # 
  #   it_should_behave_like 'It is successful'
  # end

  describe 'POST url(:pages)' do
  end

  describe 'POST url(:child_pages)' do
  end

  describe 'POST url(:clone_page)' do
  end
end