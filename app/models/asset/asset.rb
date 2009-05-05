class Asset
  include DataMapper::Resource

  property :id,               Integer, :serial => true
  property :type,             Discriminator
  property :identifier,       String, :lenght => 256, :nullable => false, :unique => true
  property :venue_id,         Integer
  property :last_checkin_at,  DateTime

  is :permalink, :identifier, :length => 60, :unique => true

  belongs_to :venue
  has n, :history, :class_name => "AssetLog"

  after :save, :update_log

  validates_present :identifier, :slug

  def self.inuse
    all(:venue_id.not => nil)
  end

  def self.available
    all(:venue_id => nil)
  end

  def self.all_for_user(user)
    if user.root?
      return all
    else
      return all(Asset.venue.corp.id => user.corporation.id)
    end
  end

  def update_log
    asset_log = AssetLog.first(:asset_id => self.id, :order => [:created_at.desc])
    AssetLog.create(:asset => self, :venue => self.venue) if asset_log.nil? or self.venue != asset_log.venue
  end

  def available?
    venue.nil?
  end

  def inuse?
    not available?
  end

  alias_method :to_hash, :to_mash

  def to_json
    to_hash.to_json
  end
end
