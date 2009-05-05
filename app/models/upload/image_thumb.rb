class ImageThumb < Thumb
  property :height, Integer
  property :width,  Integer


  def write_to_bucket
    unless @data.nil?
      ImageScience.with_image @data[:tempfile].path do |img|
        img.thumbnail(150) do |thumb|
          thumb.save UploadManager.bucketize(Merb.dir_for(:uploads), filename)
        end
      end
    end
  end
end