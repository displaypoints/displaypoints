class Campaigns < Application
  before :ensure_authenticated

  def index
    @campaigns = session.user.campaigns
    display @campaigns
  end

  def new
    @campaign = Campaign.new
    @prev_campaigns = Campaign.all(:user_id => session.user.id)
    #@used_pages = @prev_campaigns.map {|c| c.pages}.flatten.uniq
    #@unused_pages = Page.all(:id.not => @used_pages.map {|p| p.id})
    render
  end

  def create(campaign) 
    publish_groups = PublishGroup.all(:id.in => campaign[:publish_group_id])
    campaign.delete(:publish_group_id)

    @campaign = Campaign.new(campaign.merge(:publish_groups => publish_groups, :corporation => session.user.corporation, :exec => session.user))
    if @campaign.save
      redirect url(:campaign_new_content, @campaign)
    else
      render :new
    end
  end

  def show(id)
    @campaign = Campaign.get(id)
    display @campaign
  end

  def edit(id)
    @campaign = Campaign.get(id)
    @admin_assignments = CampaignAssignment.all(:campaign_id => @campaign.id, :admin => true)
    #@viewer_assignments = CampaignAssignment.all(:campaign_id => @campaign.id, :admin => false)
    @prev_campaigns = Campaign.all(:user_id => session.user.id)
    render
  end

  def update(id, campaign)
    @campaign = Campaign.get(id) || raise(CampaignNotFound, id)

    @campaign.update_attributes(campaign)

    if not @campaign.dirty?
      redirect url(:campaign, @campaign)
    elsif @campaign.save?
      redirect url(:campaign, @campaign)
    else
      render :edit
    end
  end

  def new_content(id)
    @campaign = Campaign.get(id)
    @content_item = ContentItem.new
    # @prev_campaigns = Campaign.all(:user_id => session.user.id, :id.not => @campaign.id)
    render 
  end

  def add_content(id, content_item)
    @campaign = Campaign.get(id)
    pages = Page.all(:id.in => content_item["pages"])
    resolution = Resolution.first(:id => content_item["resolution"])
    tags = content_item.delete(:tags).split(', ').map{|t| Tag.first_or_create(:name => t)}
    @content_item = ContentItem.new(content_item.merge(:pages => pages, :resolution => resolution, :tags => tags))
    if @content_item.save
      @campaign.content_items << @content_item
      @campaign.save
    end
  end
end
