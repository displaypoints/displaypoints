class Campaign
  include DataMapper::Resource

  property :id,     Serial
  property :name,   String, :length => 256
  property :state,  Enum[:initiated, :assigned, :populated, :scheduled], :default => :initiated, :nullable => false

  has n, :content_items, :through => Resource
  has n, :publish_groups, :through => Resource

  has n, :campaign_assignments
  has n, :contracts
  has n, :users, :through => :campaign_assignments
  belongs_to :exec, :class_name => "User"
  belongs_to :corporation

  is :permalink, :name, :length => 60, :unique => true

  validates_with_method :contextual_validation

  validates_present     :name,                  :group => [:initiated, :assigned, :populated, :scheduled]
  validates_present     :exec,                  :group => [:initiated, :assigned, :populated, :scheduled]
  validates_with_method :exec_has_auth,         :group => [:initiated, :assigned, :populated, :scheduled]
  validates_with_method :exec_belongs_to_corp,  :group => [:initiated, :assigned, :populated, :scheduled]
  validates_present     :corporation,           :group => [:initiated, :assigned, :populated, :scheduled]
  validates_present     :publish_groups,        :group => [:assigned, :populated, :scheduled]
  #validates_present     :campaign_assignments,  :group => [:assigned, :populated, :scheduled]
  validates_present     :content_items,         :group => [:populated, :scheduled]
  validates_present     :contracts,              :group => [:scheduled]

  def files
    self.content_items.map {|ci| ci.files}.flatten
  end

  alias_method :filelist, :files

  def venues
    venues = []
    self.publish_groups.each do |pg|
      venues += pg.venue_set
    end
    filtered_venues = []
    venues.each do |v| 
        if self.corporation.master or self.corporation.advertiser
            filtered_venues << v
        elsif self.corporation.has_venues?
            filtered_venues << v if v.corp == self.corporation
        end
    end
    filtered_venues
  end

  def purpose
    return 'ad' if self.exec.corporation.advertiser
    return 'content'
  end

  def price_per_day
    Price.campaign_per_day(self)
  end

  def serialize(base_path, contract)
    self.content_items.inject(Hash.new {|h, k| h[k] = []} ) do |h, ci|
      h[ci.name] << ci.serialize(self.purpose,
                                    ci.layout,
                                    Array(ci.tags),
                                    ci.cron_schedules.to_s,
                                    contract.runtime_tag)

      h
    end
  end

  def assign!
    update_attributes(:state => :assigned)
  end

  def assigned?
    self.state == :assigned
  end

  def populate!
    update_attributes(:state => :populated)
  end

  def populated?
   self.state == :populated
  end

  def schedule!
    update_attributes(:state => :scheduled)
  end

  after :schedule!,  :record_activity

  def scheduled?
    self.state == :scheduled
  end

  alias_method :to_hash, :to_mash

  def to_json(*args)
    to_mash(*args).to_json
  end

  private

  def contextual_validation
    valid?(self.state)
  end

  def exec_belongs_to_corp
    unless exec.nil? || exec.corporation == self.corporation
      [false, "User #{exec.name} is not an employee of #{self.corporation.name}."]
    else
      true
    end
  end

  def exec_has_auth
    unless exec.nil? || exec.admin?
      [false, "User #{exec.name} is not authorized to create a campaign."]
    else
      true
    end
  end

  def record_activity
    Activity::NewCampaign.create(:corporation => self.corporation, :user => self.exec, :campaign => self)
  end
end
