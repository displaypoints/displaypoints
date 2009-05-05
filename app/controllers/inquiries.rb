class Inquiries < Application
  before :ensure_authenticated
  before :get_survey
  
  def create(inquiry)
    only_provides :json
    @inquiry = Inquiry.new(inquiry.merge(:survey_id => @survey.id))
    if @inquiry.save
      return @inquiry.serialize.to_json
    else
      return {}.to_json
    end
  end
  
  def update(id, inquiry)
    only_provides :json
    @inquiry = Inquiry.get(id)
    if @inquiry.update_attributes(inquiry)
      return @inquiry.serialize.to_json
    else
      return {}.to_json
    end
  end
  
  def destroy(id)
    only_provides :json
    @inquiry = Inquiry.get(id)
    if @inquiry.destroy
      return @inquiry.serialize.to_json
    else
      return {}.to_json
    end
  end
  
  protected
    def get_survey
      @page = Page.get(params[:page_id])
      @survey = @page.survey
    end
end