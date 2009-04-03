Page.fixture(:zero_depth) {{
  :parent       => (parent = Page.gen(:root)),
  :content_type => [:flat, :rss, :input, :flash].pick,
  :user         => User.gen,
  :media        => ImageMedia.pick
}}

Page.fixture(:root) {{
  :user => User.gen,
  :content_type => [:flat, :rss, :input, :flash].pick,
  :media        => ImageMedia.pick
}}

given "a page => @page" do
  @page = Page.gen(:root)
end

given 'a root page => @root_page' do
  @root_page = Page.gen(:root)
end

given "sibling pages => @first_page, @second_page" do
  root_page = Page.gen(:root)
  
  @first_page = Page.gen(:zero_depth, :parent => root_page)
  @second_page = Page.gen(:zero_depth, :parent => root_page)
end

given 'an unsaved root page => @root_page' do
  @root_page = Page.make(:root)
end

given "a zero depth child page => @child_page" do
  @child_page = Page.gen(:zero_depth)
end

given "an unsaved zero depth child page => @child_page" do
  @child_page = Page.make(:zero_depth)
end

given "two linked pages => @source_page, @destination_page" do
  @source_page, @destination_page = Page.gen(:root), Page.gen(:zero_depth)

  link = Link.gen(:source_page => @source_page, :destination_page => @destination_page)

  @source_page.outgoing_links << link
  @destination_page.incoming_links << link
end

given "multiple pages => @pages" do
  @pages = (3..5).of {Page.gen(:root)}
end

given "a page with outgoing links => @page" do
  destination_pages = (3..5).of {Page.gen(:zero_depth)}
  @page = Page.gen(:root)

  destination_pages.each do |dp|
    link = Link.gen(:source_page => @page, :destination_page => dp)
    @page.outgoing_links << link
    dp.incoming_links << link
  end
end

given "a page with incoming links => @page" do
  source_pages = (3..5).of {Page.gen(:root)}
  @page = Page.gen(:zero_depth)

  source_pages.each do |sp|
    link = Link.gen(:source_page => sp, :destination_page => @page)
    sp.outgoing_links << link
    @page.incoming_links << link
  end
end

given "a self referential page => @page" do
  @page = Page.gen(:root)

  link = Link.create!(Link.gen_attrs.merge(:source_page => @page, :destination_page => @page))
  @page.outgoing_links << link
  @page.incoming_links << link
end