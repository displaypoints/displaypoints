class Venues < Application
  before :ensure_authenticated
  def index(state = nil, corp = nil, terms = nil)
    query = {}
    query.merge!(Venue.state.code => state) unless state.blank?
    query.merge!(Venue.corp.slug => corp) unless corp.blank?
    query.merge!(:name.like => terms) unless terms.blank?

    @venues = Venue.all(query)
    display @venues
  end

  def show(id)
    @venue = Venue.first(:id => id) || raise(VenueNotFound, id)
    dbase = DeployBase.first
    publisher = Publisher.new(dbase)
    @venue_content = publisher.build_venue(@venue)
    display @venue
  end

  def new
    @venue = Venue.new
    render
  end

  def create(venue)
    @venue = Venue.new(venue.except(:zipcode, :state_id, :city))

    @venue.state = unless venue[:state_id].blank?
      State.first(:id => venue[:state_id])
    end

    @venue.city = unless venue[:city].blank?
      City.first(:name => venue[:city], City.state.id => @venue.state.id) || City.create(:name => venue[:city], :state => @venue.state)
    end

    @venue.zipcode = unless venue[:zipcode].blank?
      Zipcode.first(:code => venue[:zipcode]) || Zipcode.create(:code => venue[:zipcode])
    end

    if @venue.save
      redirect url(:venue, @venue)
    else
      render :new
    end
  end

  def edit(id)
    @venue = Venue.first(:id => id) || raise(VenueNotFound, id)
    render
  end

  def update(id, venue)
    @venue =  Venue.first(:id => id) || raise(VenueNotFound, id)

    unless venue[:corp].blank?
      @venue.corp = Corporation.first(:slug => venue[:corp]) || raise(NotFound, venue[:corp])
    end

    unless venue[:state].blank?
      @venue.state = State.first(:code => venue[:state]) || raise(NotFound, venue[:state])
    end

    unless venue[:city].blank?
      @venue.city = City.first(:name => venue[:city], City.state.id => @venue.state.id) || City.create(:name => venue[:city], :state => @venue.state)
    end

    unless venue[:zipcode].blank?
      @venue.zipcode = Zipcode.first(:code => venue[:zipcode]) || Zipcode.create(:code => venue[:zipcode])
    end

    if not @venue.dirty?
      redirect url(:venue, @venue)  # not sure if it should 304 : Not Modified
    elsif @venue.save
      redirect url(:venue, @venue)
    else
      render :edit
    end
  end

  def destroy(id)
    @venue = Venue.first(:id => id) || raise(VenueNotFound, id)
    @venue.destroy
    redirect url(:venues, :message => "#{@venue.name} has been deleted")
  end

  #total hack for 12/22/2008 demo
  def manifest
    base = DeployBase.first
    manifest_file = "#{base.deploy_path}" / params[:venue_mac] / "content" / "manifest.json"
    return File.open(manifest_file, 'r').read
  end

  class VenueNotFound < NotFound; end
end
