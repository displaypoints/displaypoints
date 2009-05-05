StateAssignment.fixture {{
    :included => [true, false].pick,
    :state => State.pick,
    :publish_group => PublishGroup.pick
}}

CityAssignment.fixture {{
    :included => [true, false].pick,
    :city => City.pick,
    :publish_group => PublishGroup.pick
}}

ZipcodeAssignment.fixture {{
    :included => [true, false].pick,
    :zipcode => Zipcode.pick,
    :publish_group => PublishGroup.pick
}}

VenueAssignment.fixture {{
    :included => [true, false].pick,
    :venue => Venue.gen,
    :publish_group => PublishGroup.pick
}}