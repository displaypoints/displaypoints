class Page
  include DataMapper::Resource

  property :id,           Serial
  property :token,        DM::UUID, :nullable => false, :default => lambda { ::UUID.timestamp_create }, :index => true
  property :content_url,  String,   :length => 256,     :default => ''
  property :content_type, Enum[:flat, :rss, :input, :flash]

  is :tree, :order => [:id]

  has n, :outgoing_links, :class_name => "Link", :child_key => [:source_id]
  has n, :destination_pages, :class_name => "Page", :child_key => [:destination_id], :through => :outgoing_links
  has n, :incoming_links, :class_name => "Link", :child_key => [:destination_id]
  has n, :source_pages, :class_name => "Page", :child_key => [:source_id], :through => :incoming_links
  has n, :content_items, :through => Resource
  has 1, :media, :class_name => "Media"
  has 1, :thumb
  has 1, :survey

  belongs_to :user

  validates_present :user
  validates_present :content_type
  validates_with_method :referential_paradox

  attr_accessor :media_data, 
                :asset_path, 
                :thumb_path, 
                :asset_id, 
                :top_margin

  before :save do
    if new_record? && content_type == :input
      self.survey ||= Survey.new
      self.survey.top_margin = 100
    end
  end

  def self.all_root_for_user(user)
    if user.root?
      return roots
    end

    if user.admin?
      return roots.all(Page.user.corporation.id => user.corporation.id) 
    end

    roots.all(Page.user.id => user.id)
  end

  def self.all_for_user(user)
    if user.root?
      return all
    end

    if user.admin?
      return all(Page.user.corporation.id => user.corporation.id) 
    end

    all(Page.user.id => user.id)
  end

  def self.child_pages
    all(:parent_id.not => nil)
  end

  def self.content_types
    properties[:content_type].type.flag_map.sort.map{|a,b| b}
  end

  def referential_paradox
    if outgoing_links.any? {|l| l.destination_page == self} ||
       incoming_links.any? {|l| l.source_page == self}

      [false, "A Page cannot link to itself"]
    else
      true
    end
  end
  
  def root?
    parent.nil?
  end

  def files
    [media.full_path] + outgoing_links.map {|l| l.destination_page.files }.flatten
  end
  
  def asset_id=(id)
    pg = Page.get(id)
    self.media = ImageMedia.new(pg.media.attributes.except(:id, :page_id))
    self.thumb = ImageThumb.new(pg.thumb.attributes.except(:id, :page_id))
  end

  alias_method :to_hash, :to_mash

  def to_json(*args)
    to_mash(*args).to_json
  end

  def clone(attrs)
    Page.new(attrs.merge(:media => self.media, :thumb => self.thumb))
  end
  
  def has_links?
    !outgoing_links.empty?
  end

  after :create, :record_activity

  def record_activity
    Activity::NewPage.create(:corporation => self.user.corp_role.corporation, :user => self.user, :page => self) if root?
  end
end
