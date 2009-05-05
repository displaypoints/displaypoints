class ImageMediaObserver
  include DataMapper::Observer

  observe ImageMedia

  after :create do
    self.page.update_attributes(:thumb => ThumbManager.thumb_for_media(self))
  end
end
