class PageObserver
  include DataMapper::Observer

  observe Page

  after :media_data= do
    throw(:halt, "upload data is missing") if @media_data.blank?
    self.media = MediaManager.media_for_data(@media_data)
  end
end