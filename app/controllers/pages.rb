class Pages < Application
  before :ensure_authenticated

  def index
    @root_pages = session.user.pages.all(:parent_id => nil)
    render
  end

  def show(id)
    @page = Page.get(id)
    display @page, :template => "pages/#{@page.content_type}"
  end

  def new_root
    @page = Page.new
    render
  end

  def create_root(page)
    provides :json, :html
    @page = Page.new(page.merge(:user => session.user).except(:parent))
    if @page.save
      redirect url(:page, @page)
    else
      render :new_root
    end
  end

  def new_child(id)
    @parent = Page.get(id)
    @page = Page.new
    render
  end

  def create_child(id, page)
    @parent = Page.get(id)
    @page = Page.new(page.merge(:parent => @parent, :user => session.user))

    if @page.save
      redirect url(:page, @page)
    else
      render :new_child
    end
  end
end
