class PublishGroups < Application
  before :ensure_authenticated

  def index
    provides :json
    case content_type
    when :json then
      return {
        :type => params[:type], 
        :objects => find_children(params[:type])
      }.to_json
    else
      @publish_groups = session.user.publish_groups
      display @publish_groups
    end
  end

  def show(id)
    @publish_group = PublishGroup.first(:slug => id)
    display @publish_group
  end

  def new
    @publish_group = PublishGroup.new
    display @publish_group
  end

  def create(publish_group)
    provides :json
    @publish_group = PublishGroup.new(publish_group.merge(:user => session.user))
    if @publish_group.save
      case content_type
      when :json then
        return @publish_group.to_json
      else
        redirect url(:publish_group, @publish_group)
      end
    else
      render :new
    end
  end
  
  protected
    
    def find_children(type)
      children = Object.const_get(type.titlecase).all(:id => params[:ids].split(',')).map{|o| o.children}.flatten
      if type == 'zipcode' && session.user.corp_role.role == :venue
        children.reject!{|c| c.corp != session.user.corporation }
      end
      children.map{|c| {:id => c.id, :name => c.name}}
    end
 
end
