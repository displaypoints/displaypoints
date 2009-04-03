PublishGroup.fixture {{
  :name => (2..5).of {/\w+/.gen.capitalize} * ' ',
  :user => User.gen
}}

given "an unsaved publish group => @publish_group" do

  @publish_group = PublishGroup.make
end

given "a publish group with many assignments => @publish_group" do

  @publish_group = PublishGroup.gen

  @publish_group.venue_assignments = 5.of {VenueAssignment.gen(:publish_group => @publish_group)}
  @publish_group.state_assignments = 5.of {StateAssignment.gen(:publish_group => @publish_group)}
  @publish_group.city_assignments = 5.of {CityAssignment.gen(:publish_group => @publish_group)}
  @publish_group.zipcode_assignments = 5.of {ZipcodeAssignment.gen(:publish_group => @publish_group)}
end

given "multiple publish groups => @publish_groups" do

  @publish_groups = (3..5).of do
    pg = PublishGroup.gen

    pg.venue_assignments = 5.of {VenueAssignment.gen(:publish_group => @publish_group)}
    pg.state_assignments = 5.of {StateAssignment.gen(:publish_group => @publish_group)}
    pg.city_assignments = 5.of {CityAssignment.gen(:publish_group => @publish_group)}
    pg.zipcode_assignments = 5.of {ZipcodeAssignment.gen(:publish_group => @publish_group)}

    pg
  end
end