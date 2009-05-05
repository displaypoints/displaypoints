class VenueAssignment
  include DataMapper::Resource
  
  property :id, Serial
  property :included, Boolean #if false, then the city it belongs to is excluded from the PublishGroup
  property :venue_id, Integer

  belongs_to :venue
  belongs_to :publish_group
end
