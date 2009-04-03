class Corporation
  include DataMapper::Resource

  property :id, Integer, :serial => true
  property :type, Discriminator
  property :name, String, :length => 256, :nullable => false
  property :master, Boolean, :default => false #only true for Displaypoints Inc
  property :advertiser, Boolean, :default => false
  property :brand, String, :default => "", :length => 256

  has n, :venues
  has n, :roles, :class_name => "CorpRole"
  has n, :users, :through => :roles
  has n, :campaigns
  has n, :activities

  is :permalink, :name, :length => 60, :unique => true

  def contracts
    campaigns.map {|c| c.contracts}.flatten.uniq
  end
  
  def has_venues?
    self.venues.length > 0
  end

  # HACK: stupid datamapper
  def venues
    Venue.all(:corporation_id => self.id)
  end
end
