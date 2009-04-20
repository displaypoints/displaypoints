require 'ruby-debug'

class FlashThumb < Thumb
  property :height, Integer
  property :width,  Integer


  def write_to_bucket
    debugger
    puts("image_thumb :S")
    temp_path = Merb.dir_for(:uploads) + "/flash_image.png"
    puts(temp_path)
    
    unless @data.nil?
      ImageScience.with_image temp_path do |img|
        img.thumbnail(150) do |thumb|
          thumb.save UploadManager.bucketize(Merb.dir_for(:uploads), filenameThumb)
        end
      end
    end
  end
end