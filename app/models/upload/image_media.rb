class ImageMedia < Media
  property :height, Integer
  property :width,  Integer

  def data=(data)
    extract_dimensions(data[:tempfile])

    super(data)
  end

  def extract_dimensions(tempfile)
    ImageScience.with_image tempfile.path do |img|
      self.height = img.height
      self.width = img.width
    end
  end
  
    
    def make_thumb
      unless File.exists?(thumb_dir)
        FileUtils.mkdir_p(thumb_dir, :mode => 0o755)
      end
      ImageScience.with_image tempfile.path do |img|
        img.thumbnail(150) do |thumb|
          thumb.save thumb_path
        end
      end
    end
end