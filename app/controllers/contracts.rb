class Contracts < Application
  before :ensure_authenticated
  def index
    @contracts = Contract.all
    display @contract
  end

  def new
    @contract = Contract.new
    if params[:campaign_id].nil?
      render
    else
      @campaign = Campaign.get(params[:campaign_id])
      render :new_campaign_contract
    end
  end
  
  def create(contract)
    @contract = Contract.new(contract)
    @contract.campaign_id = params[:campaign_id]
    if @contract.save
      if @contract.campaign.nil?
        redirect url(:contract, @contract)
      else
        redirect url(:campaign, @contract.campaign)
      end
    else
      render :new
    end
  end

  def show(id)
    @contract = Contract.get!(id)
    display @contract
  end
  
  def edit(id)
    @contract = Contract.get!(id)
    render
  end
  
  def update(id, contract)
    @contract = Contract.get!(id)
    if @contract.update_attributes(contract)
      redirect url(:contract, @contract)
    else
      render :edit
    end
  end

  def approve(id)
    @contract = Contract.get!(id)
    @contract.approve
    redirect url(:contracts)
  end

  def unapprove(id)
    @contract = Contract.get!(id)
    @contract.unapprove
    redirect url(:contracts)
  end
  
  def destroy(id)
    @contract = Contract.get!(id)
    @contract.destroy
    redirect url(:contracts)
  end
end
