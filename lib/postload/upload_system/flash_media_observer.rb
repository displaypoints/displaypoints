class FlashMediaObserver
  include DataMapper::Observer

  observe FlashMedia

  after :create do
    self.page.update_attributes(:thumb => ThumbManager.thumb_for_media(self))
  end
end
