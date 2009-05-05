class CityAssignment
  include DataMapper::Resource
  
  property :id, Serial
  property :included, Boolean  #if true then include, else exclude
  property :city_id, Integer

  belongs_to :city
  belongs_to :publish_group
end
