class Corporations < Application
  before :ensure_authenticated
  def index
    @corporations = Corporation.all
    display @corporations
  end
  
  def show(slug)
    @corporation = Corporation.first(:slug => slug) || raise(CorporationNotFound, slug)
    display @corporation
  end
  
  def new
    @corporation = Corporation.new
    render
  end
  
  def create(corporation)
    @corporation = Corporation.new(corporation)
    if @corporation.save
      redirect url(:corporation, @corporation)
    else
      render :new
    end
  end
  
  def edit(slug)
    @corporation = Corporation.first(:slug => slug)

    render
  end
  
  def update(slug, corporation)
    @corporation = Corporation.first(:slug => slug) || raise(CorporationNotFound, slug)

    @corporation.update_attributes(corporation)

    if not @corporation.dirty?
      redirect url(:corporation, @corporation)
    elsif @corporation.save?
      redirect url(:corporation, @corporation)
    else
      render :edit
    end
  end
  
  def destroy(slug)
    @corporation = Corporation.first(:slug => slug) || raise(CorporationNotFound, slug)
    @corporation.destroy
    redirect url(:corporation, @corporation)
  end

  class CorporationNotFound < NotFound; end
end
