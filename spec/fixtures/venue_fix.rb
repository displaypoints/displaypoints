Venue.fixture {{
  :state    => State.pick,
  :city     => City.gen,
  :zipcode  => Zipcode.gen,
  :name     => (1..3).of {Randgen.word.capitalize} * ' ',
  :street   => /\d{2,3} \w+ (Way|Drive|Street)/.gen,
  :corp     => Corporation.gen(:venue),
  :router   => [nil, Router.gen].pick,
  :chargers => (1..3).of {Charger.gen},
  :displays => (3..10).of {Display.gen}
}}

Venue.fixture(:assetless) {{
  :state    => State.pick,
  :city     => City.pick,
  :zipcode  => Zipcode.pick,
  :name     => (1..3).of {Randgen.word.capitalize} * ' ',
  :street   => /\d{2,3} \w+ (Way|Drive|Street)/.gen,
  :corp     => Corporation.pick
}}

given "multiple venues => @venues" do
  DataMapper.auto_migrate!

  @venues = (3..5).of {Venue.gen}
end

given "a venue => @venue" do

  @venue = Venue.gen
end

given "an unsaved venue => @venue" do

  @venue = Venue.make
end
