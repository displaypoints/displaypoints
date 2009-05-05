#Link creation and destination_page creation are too tightly coupled. It is impossible to create a destination page and link separately. While the concept of a link and destination page are closely related, the tight coupling makes these two classes rather fragile. 
class Link
  include DataMapper::Resource
  
  property :id,             Serial
  property :token,          DM::UUID, :nullable => false, :default => lambda { ::UUID.timestamp_create }, :index => true
  property :height,         Integer, :nullable => false
  property :width,          Integer, :nullable => false
  property :x_coord,        Integer, :nullable => false
  property :y_coord,        Integer, :nullable => false
  property :source_id,      Integer, :nullable => false
  property :destination_id, Integer, :nullable => false

  belongs_to :source_page, :class_name => "Page", :child_key => [:source_id]
  belongs_to :destination_page, :class_name => "Page", :child_key => [:destination_id]
  
  attr_accessor :current_user
  
  before :valid? , :save_dest_page

  def serialize
    {"destination" => self.destination_page.token.hexdigest,
     "type" => "rectangle",
     "upper_left_x" => self.x_coord,
     "upper_left_y" => self.y_coord,
     "width" => self.width,
     "height" => self.height,
     "link_id" => self.token}
  end
  
  def dest_attrs=(attrs)
    attrs.delete('media_data') if attrs['media_data'].blank?
    attrs.delete('asset_id') if attrs['asset_id'].blank?
    self.destination_page = Page.new(attrs.merge(:user => current_user))    
  end
  
  before :save do
    self.destination_page.parent_id = self.source_id
  end
  
  def save_dest_page
    if new_record? && !destination_page.nil? && !source_page.nil?
      pg = self.destination_page
      pg.parent_id = source_id
      #pg.node = source_page.node + 1
      pg.user = @current_user
      throw :halt unless pg.valid?
      pg.save
    end
  end
end
