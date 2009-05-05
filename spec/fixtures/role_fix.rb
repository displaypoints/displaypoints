CorpRole.fixture {{
  :role   => :ad,
  :admin  => false,
  :user   => User.make(:ad_user),
  :corporation  => Corporation.gen(:ad)
}}

CorpRole.fixture(:admin) {{
  :role   => [:dp, :ad, :venue].pick,
  :admin  => :true,
  :user   => User.make(:ad_user),
  :corporation  => Corporation.gen(:ad)
}}

CorpRole.fixture(:root) {{
  :role         => :dp,
  :admin        => true,
  :corporation  => Corporation.gen(:master)
}}

CorpRole.fixture(:venue_admin) {{
  :role         => :venue,
  :admin        => true,
  :corporation  => Corporation.gen(:venue)
}}

given "an admin CorpRole => @admin_corp_role" do
  @admin_corp_role = CorpRole.gen(:admin => true)
end

given "a normal CorpRole => @corp_role" do
  @corp_role = CorpRole.gen
end

given "a root CorpRole => @root_role" do
  @root_role = CorpRole.gen(:root)
end
