class FlashMedia < Media
  property :height, Integer
  property :width,  Integer

  def data=(data)
    extract_dimensions(data[:tempfile])

    super(data)
  end

  def extract_dimensions(tempfile)
    temp_path = Merb.dir_for(:uploads) + "/flash_image.png"
    ImageScience.with_image temp_path do |img|
      self.height = img.height
      self.width = img.width
    end
  end
  
    
    def make_thumb
      unless File.exists?(thumb_dir)
        FileUtils.mkdir_p(thumb_dir, :mode => 0o755)
      end
      temp_path = Merb.dir_for(:uploads) + "/flash_image.png"
      ImageScience.with_image temp_path do |img|
        img.thumbnail(150) do |thumb|
          thumb.save thumb_path
        end
      end
    end
end