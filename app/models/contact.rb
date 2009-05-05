class Contact
  include DataMapper::Resource
  
  property :id,             Serial
  property :name,           String, :length => 256
  property :role,           String, :length => 256
  property :phone,          String, :length => 15
  property :email,          String, :length => 256
  property :venue_id,       Integer
  
  belongs_to :venue
end