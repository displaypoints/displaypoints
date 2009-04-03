class Links < Application
  before :ensure_authenticated
  before :find_parent
  def new
    @link = Link.new
    render
  end
  
  def create(link)
    @link = Link.new(link.merge(:source_page => @parent, :current_user => session.user))
    if @link.save
      redirect url(:page, @link.source_page)
    else
      render :new
    end
  end
  
  def edit(id)
    @link = Link.get!(id)
    render
  end
  
  def update(id, link)
    provides :json
    @link = Link.get!(id)
    if @link.update_attributes(link)
      if content_type == :json
        return {:success => "ok"}.to_json
      else
        redirect url(:page, @link.source_page)
      end
    else
      render :edit
    end
  end
  
  def remove(id)
    @link = Link.get!(id)
    render
  end
  
  def destroy(id)
    @link = Link.get!(id)
    @link.destroy
    redirect url(:page, @link.source_page)
  end
  
  protected
    def find_parent
      @parent = Page.get!(params[:parent_id])
    end
end
