class Surveys < Application
  before :ensure_authenticated

  def update
    provides :json
    @page = Page.get(params[:page_id])
    if @page.survey.update_attributes(params[:survey])
      return @page.survey.to_json
    else
      return "error"
    end
  end
end