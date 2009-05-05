class DeployBase
  include DataMapper::Resource

  property :id,     Serial
  property :name,   String
  property :deploy_path, String

  #belongs_to :campaign, :class_name => "Campaign" #must be owned by displaypoints
  belongs_to :contract, :class_name => "Contract" #must be owned by displaypoints
  belongs_to :menu, :class_name => "Menu"
  belongs_to :publish_group, :class_name => "PublishGroup" #for 1.1 release

  def filenames
    self.menu.filenames + self.campaign.filenames
  end
  
  def json
    self.menu_json.merge(self.campaign_json)
  end

  def menu_json
    self.menu.json_data(self.deploy_path)
  end

  def campaign_json
    self.contract.campaign.json_data(self.deploy_path)
  end
end
