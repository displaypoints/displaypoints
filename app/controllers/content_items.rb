class ContentItems < Application
  before :ensure_authenticated

  def show(id)
    @content_item = ContentItem.get(id)
    display @content_item
  end

  def new
    @content_item = ContentItem.new
    render
  end

  def create(content_item)
    provides :json
    resolution = Resolution.get(content_item.delete(:resolution))
    tags = content_item.delete(:tags).split(', ').map{|t| Tag.first_or_create(:name => t)}
    pages = Page.roots.all(:id.in => content_item.delete(:pages).split(','))
    campaign = Campaign.get(content_item.delete(:campaign_id))
    @content_item = ContentItem.new(content_item.merge(:resolution => resolution, 
                                                       :tags => tags, 
                                                       :pages => pages, 
                                                       :campaigns => [campaign]))
    if @content_item.save
      if content_type == :json
        return @content_item.to_json
      else
        redirect url(:content_item, @content_item)
      end
    else
      render :new
    end
  end
end
