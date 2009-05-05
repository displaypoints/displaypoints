class Display < Asset
  
  property :last_checkin_at, DateTime
  property :update_status, Enum[:started, :successful, :failed], :default => :successful, :nullable => false
  property :last_update_at, DateTime
  property :do_update, Boolean, :default => false

  belongs_to :resolution
  belongs_to :rpm

  validates_present :resolution
  validates_format :identifier, :with => /^([A-F0-9]{2}:){5}([A-F0-9]{2})$/

  attr_accessor :rpm_name

  before :save do
    self.rpm = Rpm.find_by_name(rpm_name) if not :rpm_name.nil? and self.new_record?
  end

  def self.all_unknown_update_status
    all(:update_status => :started, :last_update_at.lt => 1.day.ago)
  end

  def self.all_failed_updates
    all(:update_status => :failed)
  end

  def has_update?
    return true if self.do_update and Rpm.update_available?(self.rpm)
    return false
  end

  def update_path
    return Rpm.get_update(rpm).rpm_media.path #if not rpm.nil?
  end

  def start_update
    self.update_status = :started
    self.save
  end

  def successful_update
    self.update_status= :successful
    self.do_update = false
    self.last_update_at = Time.now
    self.save
  end

  def failed_update
    self.update_status = :failed
    self.last_update_at = Time.now
    self.save
  end
end
