Charger.fixture {{
  :identifier => /\d{5}-\d{3}/.gen,
}}

Display.fixture {{
  :identifier => 6.of{ /(A|B|C|D|E|F|\d){2}/.gen }.join(':'),
  :resolution => Resolution.pick
}}

Router.fixture {{
  :identifier => 6.of{ /(A|B|C|D|E|F|\d){2}/.gen }.join(':'),
}}

given "an asset => @asset" do
  @asset = [Charger, Display, Router].pick.gen
end

given "an unassociated asset => @unassoc" do
  @unassoc = [Charger, Display, Router].pick.gen
end

given "an associated asset => @assoc" do
  Resolution.gen; City.gen; Zipcode.gen; Corporation.gen; Venue.gen(:assetless)
  @assoc = [Charger, Display, Router].pick.gen(:venue => Venue.pick(:assetless))
end

given "a charger => @charger" do
  @charger = Charger.gen
end

given "a display => @display" do
  @display = Display.gen
end

given "a router => @router" do
  @router = Router.gen
end

given "an inuse router => @router" do
  Resolution.gen; City.gen; Zipcode.gen; Corporation.gen
  venue = Venue.gen(:assetless)
  @router = Router.gen(:venue => Venue.pick(:assetless))
  venue.router = @router
end
