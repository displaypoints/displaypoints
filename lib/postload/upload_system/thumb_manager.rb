module ThumbManager
  def self.thumb_for_media(media)
    data = data_from_media(media)
    thumb_for_data(data)
  end

  def self.data_from_media(media)
    tempfile = Tempfile.new(media.digest)
    FileUtils.cp media.full_path, tempfile.path

    {:tempfile => tempfile, :content_type => media.content_type, :filename => media.filename}
  end

  def self.thumb_for_data(data)
    thumb_model_for(data[:content_type]).new(:data => data)
  end

  def self.thumb_model_for(content_type)
    case content_type
    when /^image\// then ImageThumb
    else (raise InvalidMedia, content_type)
    end
  end
end
