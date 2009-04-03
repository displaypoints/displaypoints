@pages = Page.all.entries
@links = Link.all.entries
@displays = Display.all.entries
@routers = Router.all.entries

PageAnalytic.fixture(:link) {{
  :action => "link",
  :link_id => (link = @links[rand(@links.size)]; link.token),
  :from_page => link.source_page.token,
  :to_page => link.destination_page.token,
  :coordinates => [rand(480), rand(800)],
  :timestamp => (1..10).pick.days.ago,
  :display_mac => @displays[rand(@displays.size)].identifier,
  :router_mac => @routers[rand(@routers.size)].identifier
}}

PageAnalytic.fixture(:auto_rotation) {{
  :action => "auto_rotation",
  :from_page => @pages[rand(@pages.size)].token,
  :to_page => @pages[rand(@pages.size)].token,
  :timestamp => (1..10).pick.days.ago,
  :display_mac => @displays[rand(@displays.size)].identifier,
  :router_mac => @routers[rand(@routers.size)].identifier 
}}

PageAnalytic.fixture(:user_rotation) {{
  :action => "user_rotation",
  :coordinates => [rand(480), rand(800)],
  :from_page => @pages[rand(@pages.size)].token,
  :to_page => @pages[rand(@pages.size)].token,
  :timestamp => (1..10).pick.days.ago,
  :display_mac => @displays[rand(@displays.size)].identifier,
  :router_mac => @routers[rand(@routers.size)].identifier
}}

PageAnalytic.fixture(:touch) {{
  :action => "touch",
  :coordinates => [rand(480), rand(800)],
  :timestamp => (1..10).pick.days.ago,
  :display_mac => @displays[rand(@displays.size)].identifier,
  :router_mac => @routers[rand(@routers.size)].identifier,
  :from_page => @pages[rand(@pages.size)].token
}}