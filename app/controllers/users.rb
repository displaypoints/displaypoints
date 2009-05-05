class Users < Application
  before :ensure_authenticated

  def index
    if session.user.root?
      @users = User.all
    else
      @users = session.user.corporation.users
    end

    display @user
  end

  def show(id)
    @user = User.get!(id)
    display @user
  end
  
  def new
    @user = User.new
    render
  end
  
  def create(user,corp_role)
    @user = User.create_with_role(user, corp_role, session.user)
    if @user
      redirect url(:user, @user)
    else
      render :new
    end
  end
  
  def edit(id)
    @user = User.get!(id)
    render
  end
  
  def update(id, user,corp_role)
    @user = User.get!(id)
    if @user.update_with_role(user, corp_role)
      redirect url(:user, @user)
    else
      render :edit
    end
  end

  def destroy(id)
    @user = User.get!(id)
    @user.destroy
    redirect url(:user, @user)
  end

  def hijack(id)
    raise(Unauthorized) unless session.user.root?

    session.user = User.get(id)

    redirect url(:home)
  end
end
