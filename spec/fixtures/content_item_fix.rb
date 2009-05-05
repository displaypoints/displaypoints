ContentItem.fixture(:advertisement) {{
  :name         => (2..5).of {/\w+/.gen.capitalize} * ' ',
  :pages        => (1..5).of {Page.gen(:root)}.uniq,
  :resolution   => Resolution.pick,
  :tags         => (0..3).of {Tag.gen}.uniq,
  :layout       => [:full, :skyscraper, :accepts_skyscraper].pick
}}

given "a content item => @content_item" do
  5.times {Page.gen(:root)}; 3.times {Tag.gen}
  @content_item = ContentItem.gen(:advertisement)
end

given "an advertisement item => @ad_content_item" do
  5.times {Page.gen(:root)}; 3.times {Tag.gen}
  @ad_content_item = ContentItem.gen(:advertisement)
end

given "a content item with pages => @content_item" do
  5.times {Page.gen(:root)}; 3.times {Tag.gen}
  @content_item = ContentItem.gen(:advertisement)
end