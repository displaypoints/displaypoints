# the TO WHAT EXTENT
class Contract
  include DataMapper::Resource

  property :id,           Integer, :serial => true
  property :type,         Discriminator
  property :state,        Enum[:pending, :approved], :default => :pending
  property :approved_at,  DateTime, :default => nil
  property :price,        Float
  property :start_at,     DateTime
  property :end_at,       DateTime
  property :campaign_id,  Integer

  #has n, :fulfillment_dates #not sure this is necessary so it is commented out
  belongs_to :campaign
  
  validates_present :start_at, :end_at
  validates_with_block do
    if start_at < end_at
      true
    else
      [false, "The start must be before the end"]
    end
  end
  
  def self.all_active
    now = Time.now
    #all(:start_at.lte => now, :end_at.gte => now, Contract.campaign.confirmed_at.lte => now)
    all(:start_at.lte => now, :end_at.gte => now, :state => :approved) 
  end

  def default_approval
    raise NotImplementedError
  end

  def approve
    self.state = :approved
    self.approved_at = Time.now
    self.save
  end

  def unapprove
    self.state = :pending
    self.approved_at = nil
    self.save
  end

  def runtime_tag
    {"start_datetime" => self.start_at.to_s,
     "end_datetime" => self.end_at.to_s}
  end

  def length_in_days
    (self.end_at - self.start_at).to_i
  end

  private

  after :approve, :record_activity

  def record_activity
    Activity::ContractApproved.create(:corporation => self.campaign.corporation, :user => self.campaign.exec, :contract => self)
  end
end
