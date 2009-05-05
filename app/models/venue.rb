class Venue
  include DataMapper::Resource

  property :id,             Serial
  property :name,           String, :nullable => false, :length => 256
  property :street,         String, :nullable => false, :length => 256
  property :state_id,       Integer

  has n, :assets
  has n, :chargers
  has n, :contracts
  has n, :displays
  has 1, :router
  belongs_to :corp, :class_name => Corporation
  belongs_to :city
  belongs_to :state
  belongs_to :zipcode
  has n, :in_groups, :through => Resource, :class_name => "PublishGroup"
  has n, :ex_groups, :through => Resource, :class_name => "PublishGroup"

  is :permalink, :name, :length => 60, :scope => [:corp]

  validates_present :city, :state, :zipcode, :corp

  def self.all_active
    Router.all(:venue_id.not => nil).map {|r| r.venue unless r.venue == nil}
  end

  def self.by_state(state)
    case state
    when Symbol, String, Integer
      all(Venue.state.name.like => state) + all(Venue.state.code.like => state)
    end
  end


  def self.by_city(city)
    case city
    when Symbol, String, Integer
      all(Venue.city.name.like => city)
    end
  end

  def self.by_zipcode(zipcode)
    case zipcode
    when Symbol, String, Integer
      all(Venue.zipcode.code.like => zipcode)
    end
  end

  def self.by_region(region)
    by_state(region) + by_city(region) + by_zipcode(region)
  end

  def self.routerless
    all(:id.not => Router.inuse.map {|r| r.venue.id})
  end
end
