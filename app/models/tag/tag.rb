class Tag
  include DataMapper::Resource

  property :id,   Integer, :serial => true
  property :type, Discriminator
  property :name, String,  :nullable => false, :length => 256

  has n, :publish_groups, :through => Resource
  has n, :content_items,  :through => Resource

  is :permalink, :name, :length => 60
end
