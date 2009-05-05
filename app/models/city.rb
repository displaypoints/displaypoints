class City
  include DataMapper::Resource

  property :id,         Serial
  property :name,       String, :length => 256, :nullable => false
  property :state_id,   Integer

  is :permalink, :name, :length => 60, :unique => [:state], :scope => [:state]

  belongs_to :state
  has n, :in_groups, :through => Resource, :class_name => "PublishGroup"
  has n, :ex_groups, :through => Resource, :class_name => "PublishGroup"
  has n, :zipcodes
  has n, :venues

  validates_present :state
  
  def children(); zipcodes end
end