class Menu
  include DataMapper::Resource

  property :id,     Serial
  property :token,  DM::UUID, :nullable => false, :default => lambda { ::UUID.timestamp_create }, :index => true
  property :root,   Boolean, :default => false
  property :title,  String
  
  has 1, :icon, :class_name => "Upload"
  has n, :targets, :class_name => "Target", :through => Resource

  def json_data(base_path)
    data = {
        'menu_title' => self.title,
        'menu_id' => self.token,
        #hardcoding the following till menu stuff gets figured out
        #'menu_icon' => "#{base_path}" / "#{self.icon.filename}",
        #'parent_menu' => nil | self.targets.menu.title
        'menu_icon' => {'icon' => '', 'menu_link' => '', 'content_link' => ''},
        'parent_menu' => ''
    }
  end

  def filelist
    return []
  end
end
