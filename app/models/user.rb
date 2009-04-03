class User
  include DataMapper::Resource

  Merb::Authentication.user_class = self
 
  property :id,     Serial
  property :email,  String, :length => 3..100, :unique => true
  property :name,   String, :lenght => 256
  property :state,  Enum[:initiated, :activated, :deactivated], :default => :initiated, :nullable => false
  property :crypted_password,           String
  property :salt,                       String
  property :remember_token_expires_at,  DateTime
  property :remember_token,             String
  property :password_reset_code,        String
  property :created_at,                 DateTime
  property :updated_at,                 DateTime

  has n, :publish_groups, :through => Resource
  has n, :campaign_assignments
  has n, :campaigns, :through => :campaign_assignments
  has n, :pages
  has n, :activities

  has 1, :corp_role
  has 1, :corporation, :through => :corp_role

  validates_with_method :contextual_validation
  validates_present   :email,     :group => [:initiated, :activated, :deactivated]
  validates_present   :name,      :group => [:initiated, :activated, :deactivated]
  validates_present   :corp_role, :group => [:activated, :deactivated]

  validates_format    :email, :as => :email_address, :group => [:initiated, :activated, :deactivated]
  validates_is_confirmed :password, :group => [:activated, :deactivated]


  attr_accessor :password, :password_confirmation
  
  before :save, :encrypt_password
  
  def library
    pages.inject({}) do |hsh, p|
      thumb = p.thumb.path
      hsh[p.id] = thumb unless hsh.values.include?(thumb)
      hsh
    end
  end
  
  def self.authenticate(email, password)
    u = self.first(:email => email)
    return nil unless u
    u.crypted_password == encrypt(u.salt, password) ? u : nil
  end

  def self.create_with_role(data, corp_role, creator)
    u = create(data)
    role = corp_role['role'].nil? ? creator.role : corp_role['role']
    u.save
  
    CorpRole.create(corp_role.merge(:user => u, :role => role))
    
    return u
  end

  def update_with_role(data, corp_role)
    update_attributes(data)
    self.corp_role.update_attributes(corp_role)
  end

  alias_method :__pages, :pages

  # TODO: still smells
  def pages
    m = {}
    __pages.each {|p| m[p.id] = p.media.digest unless m.values.include?(p.media.digest) }
    Page.all(:id.in => m.keys)
  end

  alias_method :_pages, :pages

  def pages
    if root?
      Page.all
    elsif admin?
      Page.all(:user_id.in => corporation.users.map {|u| u.id})
    else
      _pages
    end
  end

  def activate!
    update_attributes(:state => :activated)
  end

  def deactivate!
    update_attributes(:state => :deactivated)
  end

  def activated?
    self.state == :activated
  end

  alias_method :active?, :activated?

  def admin?
    corp_role.admin? unless corp_role.nil?
  end

  def root?
    corp_role.root? unless corp_role.nil?
  end

  def role
    self.corp_role.role
  end

  alias_method :_campaigns, :campaigns

  def campaigns
    if root?
      Campaign.all
    elsif admin?
      corporation.campaigns
    else
      _campaigns
    end
  end

  #DM HACK: joins are still wonky
  def contracts
    campaigns.contracts
  end

  alias_method :_activities, :activities

  def activities
    if root?
      Activity.all
    elsif admin?
      corporation.activities
    else
      _activities
    end
  end

  alias_method :_publish_groups, :publish_groups

  def publish_groups
    if root?
      PublishGroup.all
    elsif admin?
      PublishGroup.all(:user_id.in => corporation.users.map {|u| u.id})
    else
      _publish_groups
    end
  end
  
  def states
    publish_groups.map{|pg| pg.states}.flatten.compact
  end
  
  def cities
    states.map{|s| s.cities}.flatten.compact
  end
  
  def zipcodes
    cities.map{|c| c.zipcodes}.flatten.compact
  end
  
  private

  def self.encrypt(salt, password = nil)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  def encrypt_password
    self.salt ||= Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--")
    self.crypted_password ||= User.encrypt(salt, password)
  end

  def contextual_validation
    valid?(self.state)
  end
end
