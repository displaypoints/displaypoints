class RpmObserver
  include DataMapper::Observer

  observe Rpm

  after :media_data= do
    throw(:halt, "upload data is missing") if @media_data.nil?
    self.rpm_media = MediaManager.media_for_data(@media_data)
  end
end
