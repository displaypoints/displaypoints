#Rename to ABContentItem
class ContentItem
  include DataMapper::Resource

  property :id,             Serial
  property :name,           String, :length => 256
  property :layout,         Enum[:full, :skyscraper, :accepts_skyscraper]

  has n, :tags, :through => Resource
  has n, :cron_schedules, :through => Resource
  belongs_to :resolution

  has n, :pages, :through => Resource
  has n, :campaigns, :through => Resource

  is :permalink, :name, :length => 60

  validates_present :resolution
  validates_with_method :resolution_check

  def self.layouts
    properties[:layout].type.flag_map.sort.map{|a,b| b}
  end

  def thumb
    pages.first.thumb
  end

  def resolution_check
    if pages.any? {|p| p.media.height != resolution.height || p.media.width != resolution.width}
      [false, "Page resolution does not match the selected resolution"]
    else
      true
    end
  end
  
  def has_links?
    pages.any?{|pg| pg.has_links? }
  end
  
  def to_json
    {
      :name => name,
      :pages => pages.map{|p| p.thumb.path}
    }.to_json
  end

  def serial_attrs(alt, root, purpose, layout, desc_tags, cronsched, runtime_tag)
    attrs = {
      'id' => "#{alt.token.hexdigest}",
      'background' => alt.media.filename,
      'page_type' => alt.content_type,
      'purpose' => purpose,
      'layout' => layout,
      'root' => root,
      'content_url' => alt.content_url,
      'display_time' => 20, #in seconds
      'menu' => "",
      'description' => Array(desc_tags),
      'menu_icon' => "",
      'cron_tag' => cronsched,
      'runtime_tag' => runtime_tag,
      'links' => alt.outgoing_links.map {|l| l.serialize}
    }
    if alt.survey
      attrs[:questions] = []
      alt.survey.inquiries.each do |inq|
        attrs[:questions] << inq.serialize
      end
      attrs[:top_margin] = alt.survey.top_margin
    end
    attrs
  end

  def recur_serialize(srcpage, purpose, layout, desc_tags, cronsched, runtime_tag)
    serialized_pages = [serial_attrs(srcpage, false, purpose, layout, desc_tags, cronsched, runtime_tag)]
    srcpage.outgoing_links.each do | link |
      serialized_pages += recur_serialize(link.destination_page, purpose, layout, desc_tags, cronsched, runtime_tag)
    end
    serialized_pages
  end

  def serialize(purpose, layout, desc_tags, cronsched, runtime_tag)
    serialized_pages = []
    self.pages.each do |alt|
      serialized_pages << self.serial_attrs(alt, true, purpose, layout, desc_tags, cronsched, runtime_tag)
      alt.outgoing_links.each do | link |
        serialized_pages += recur_serialize(link.destination_page, purpose, layout, desc_tags, cronsched, runtime_tag)
      end
    end
    serialized_pages
  end

  def files
    pages.map {|p| p.files }.flatten
  end
end
