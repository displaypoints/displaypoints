class ZipcodeAssignment
  include DataMapper::Resource
  
  property :id, Serial
  property :included, Boolean #if false, then the city it belongs to is excluded from the PublishGroup
  property :zipcode_id, Integer

  belongs_to :zipcode
  belongs_to :publish_group
end
