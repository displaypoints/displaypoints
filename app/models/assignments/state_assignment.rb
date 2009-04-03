class StateAssignment
  include DataMapper::Resource
  
  property :id, Serial
  property :included, Boolean #if false, then the city it belongs to is excluded from the PublishGroup
  property :state_id, Integer


  belongs_to :state
  belongs_to :publish_group
end
