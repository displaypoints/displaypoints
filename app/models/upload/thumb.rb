class Thumb < Media
  belongs_to :page

  def self.for_media(media)
    raise NotImplemented
  end
  
  before :write_to_bucket, :generate_thumb

  def filename
    "#{digest}-thumb#{extname}"
  end
  
  def filenameThumb
    extname = ".png"
    "#{digest}-thumb#{extname}"
  end
  
end