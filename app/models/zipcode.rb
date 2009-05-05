class Zipcode
  include DataMapper::Resource

  property :id,           Serial
  property :code,         String, :length => 16, :nullable => false, :unique => true
  property :city_id,      Integer

  belongs_to :city
  has n, :in_groups, :through => Resource, :class_name => "PublishGroup"
  has n, :ex_groups, :through => Resource, :class_name => "PublishGroup"
  has n, :venues
  
  def name(); code end
  
  def children(); venues end
end
