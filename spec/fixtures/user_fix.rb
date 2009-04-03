User.fixture {{
  :name                   => (name = Randgen.name),
  :email                  => "#{name.downcase.gsub(/\s/,'')}@example.com",
  :password               => (password = /\w+/.gen),
  :password_confirmation  => password,
  :corp_role              => CorpRole.gen
}}

User.fixture(:root) {{
  :name                   => (name = Randgen.name),
  :email                  => "#{name.downcase.gsub(/\s/,'')}@example.com",
  :password               => (password = /\w+/.gen),
  :password_confirmation  => password
}}

User.fixture(:dp_user) {{
  :name                   => (name = Randgen.name),
  :email                  => "#{name.downcase.gsub(/\s/,'')}@example.com",
  :password               => (password = /\w+/.gen),
  :password_confirmation  => password
}}

User.fixture(:ad_admin) {{
  :name                   => (name = Randgen.name),
  :email                  => "#{name.downcase.gsub(/\s/,'')}@example.com",
  :password               => (password = /\w+/.gen),
  :password_confirmation  => password
}}

User.fixture(:ad_user) {{
  :name                   => (name = Randgen.name),
  :email                  => "#{name.downcase.gsub(/\s/,'')}@example.com",
  :password               => (password = /\w+/.gen),
  :password_confirmation  => password
}}

User.fixture(:venue_admin) {{
  :name                   => (name = Randgen.name),
  :email                  => "#{name.downcase.gsub(/\s/,'')}@example.com",
  :password               => (password = /\w+/.gen),
  :password_confirmation  => password,
  :corp_role              => CorpRole.gen(:venue_admin)
}}

User.fixture(:venue_user) {{
  :name                   => (name = Randgen.name),
  :email                  => "#{name.downcase.gsub(/\s/,'')}@example.com",
  :password               => (password = /\w+/.gen),
  :password_confirmation  => password
}}

User.fixture(:initiated) {{
  :name                   => (name = Randgen.name),
  :email                  => "#{name.downcase.gsub(/\s/,'')}@example.com",
  :password               => (password = /\w+/.gen),
  :password_confirmation  => password,
  :state                  => :initiated
}}

given "a root user => @root_user" do
  @root_user = User.gen(:root)
  @root_user.corp_role = CorpRole.gen(:root, :user => @root_user)
  @root_user.activate!
end

given "an admin user => @admin" do
  @admin = User.gen([:ad_admin, :venue_admin].pick, :corp_role => CorpRole.make(:admin))
end

given "a regular user => @user" do
  @user = User.gen([:ad_user, :venue_user].pick, :corp_role => CorpRole.make)
end

given "an unauthenticated user => @user" do
  @user = User.gen
end

given "an authenticated user => @user" do
  @user = User.gen

  response = request(url(:perform_login), :method => "PUT", :params => {:login => @user.email, :password => @user.password})
  response.should redirect
end

given "an auth'd root user => @user" do
  @user = User.gen(:root)
  @user.corp_role = CorpRole.gen(:root, :user => @user)
  @user.activate!
  response = request(url(:perform_login), :method => "PUT", :params => {:login => @user.email, :password => @user.password})
  response.should redirect
end

given "an initiated user => @user" do
  @user = User.gen(:initiated)
end

given "an activated user => @user" do
  @user = User.gen(:initiated)

  @user.corp_role = CorpRole.gen(:user => @user)
  @user.activate!
end