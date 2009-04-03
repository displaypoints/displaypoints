class Analytics < Application
  def index
    render
  end
  
  def create
    only_provides :json
    @venue = Venue.get(params[:venue_id])
    @display = Display.first(:identifier => params[:mac_address])
    @analytic = PageAnalytic.new(params[:data])
    if @analytic.save
      display @analytic
    else
      return "FAIL".to_json
    end
  end
  
  def campaign_show(type = "user_rotation", date = "#{7.days.ago.to_date.strftime('%m/%d/%Y')} - #{Date.today.strftime('%m/%d/%Y')}")
    only_provides :json
    @campaign = Campaign.get(params[:campaign_id])
    @data = PageAnalytic.format_campaign_for_ofc(@campaign, type, date)
    render
  end
  
  def content_item_show(type = "user_rotation", date = "#{7.days.ago.to_date.strftime('%m/%d/%Y')} - #{Date.today.strftime('%m/%d/%Y')}")
    only_provides :json
    @content_item = ContentItem.get(params[:content_item_id])
    @data = PageAnalytic.format_content_item_for_ofc(@content_item,type, date)
    render
  end
end