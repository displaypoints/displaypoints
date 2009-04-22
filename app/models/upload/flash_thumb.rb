class FlashThumb < Thumb
  property :height, Integer
  property :width,  Integer

  def path
    @path ||= unless digest.nil? || extname.nil?
      UploadManager.bucketize(Merb.dir_for(:uploads) - Merb.dir_for(:public), filenameThumb)
    end
  end
  
  def full_path
    @full_path ||= unless digest.nil? || extname.nil?
      UploadManager.bucketize(Merb.dir_for(:uploads), filenameThumb)
    end
  end

  def write_to_bucket
    temp_path = Merb.dir_for(:uploads) + "/flash_image.png"
    unless @data.nil?
      ImageScience.with_image temp_path do |img|
        img.thumbnail(150) do |thumb|
          thumb.save UploadManager.bucketize(Merb.dir_for(:uploads), filenameThumb)
        end
      end
    end
  end
end