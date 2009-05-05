class Resolution
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :height, Integer
  property :width, Integer
  
  is :permalink, :name, :length => 60
  
  validates_present :height
  validates_present :width

  def humanize
    return "#{self.width} x #{self.height}"
  end
end
