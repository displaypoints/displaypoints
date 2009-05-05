Corporation.fixture {{
  :name => /\w+/.gen.capitalize,
  :master => [true, false].pick
}}

Corporation.fixture(:venue) {{
  :name => /\w+/.gen.capitalize,
  :brand  => /\w+/.gen,
  :name   => /\w+/.gen.capitalize,
  :master => false
}}

Corporation.fixture(:ad) {{
  :name       => /\w+/.gen.capitalize,
  :master     => false,
  :advertiser => true
}}

Corporation.fixture(:master) {{
  :name       => /\w+/.gen.capitalize,
  :master     => true
}}

given "multiple corporations => @corporations" do

  @corporations = (3..5).of {Corporation.gen}
end

given "a corporation => @corporation" do

  @corporation = Corporation.gen
end

given "an unsaved corporation => @corporation" do

  @corporation = Corporation.make
end
