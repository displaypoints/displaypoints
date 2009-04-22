module MediaManager
  def self.media_for_data(data)
    media_model_for(data[:content_type]).new(:data => data)
  end

    
      
  def self.media_model_for(content_type)
    case content_type
    when /^image\// then ImageMedia
    when /^application\/x-rpm$/ then RpmMedia
    when /^application\/x-shockwave-flash$/ then FlashMedia
    else (raise InvalidMedia, content_type)
    end
  end
end
