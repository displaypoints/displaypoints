class Assets < Application
  before :ensure_authenticated

  def index
    @assets = Asset.all_for_user(session.user)
    display @assets
  end
  
  def show(slug)
    @asset = Asset.first(:slug => slug)
    display @asset
  end
  
  def new
    @asset = Asset.new
    render
  end
  
  def create(asset)
    venue = Venue.get!(asset[:venue])
    asset[:venue] = venue
    @asset = Asset.new(asset)
    if @asset.save
      redirect url(:asset, @asset)
    else
      render :new
    end
  end
  
  def edit(slug)
    @asset = Asset.first(:slug => slug)
    render
  end
  
  def update(slug, asset)
    @asset = Asset.first(:slug => slug)
    if @asset.update_attributes(asset)
      redirect url(:asset, @asset)
    else
      render :edit
    end
  end
  
  def destroy(slug)
    @asset = Asset.first(:slug => slug)
    @asset.destroy
    redirect url(:asset, @asset)
  end
 
  def check_in(router_mac, display_mac, rpm_name)
    @display = self._get_display(router_mac, display_mac, rpm_name)
 
    @venue = Venue.first(Venue.router.id => Router.first(:identifier => router_mac).id)
    if @display.venue != @venue or @display.venue.nil?
      @display.venue = @venue unless @venue.nil?
    end

    @display.last_checkin_at = Time.now
    @display.save if @display.dirty?
    
    return '' #Yeah, just return an empty response to generate the HTTP 200 code.
  end

  def start_update(router_mac, display_mac, rpm_name)
    only_provides :json
    @display = self._get_display(router_mac, display_mac, rpm_name)
    @update_rpm = Rpm.get_update(@display.rpm)
    @display.start_update
    render
  end

  def finish_update(display_mac, status)
    @display = Display.first(:identifier => display_mac)
    if status == "success"
      @display.successful_update
    else
      @display.failed_update
    end
    return ''
  end
  
  def _get_display(router_mac, display_mac, rpm_name)
    @display = Display.first(:identifier => display_mac)
    @display = Display.new(:identifier => display_mac, :resolution => Resolution.first, :rpm_name => rpm_name)  if @display.nil?

    return @display
  end

end
