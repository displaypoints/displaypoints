class Application < Merb::Controller
  protected
  def ensure_displaypoints
    if not session.user.corporation.master
      throw :halt, Proc.new {|c| c.redirect url(:forbidden) }
    end
    session.user.admin?
  end
end
