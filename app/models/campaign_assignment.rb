class CampaignAssignment
  include DataMapper::Resource
  
  property :id, Serial
  property :admin, Boolean, :default => false
  property :campaign_id, Integer

  belongs_to :user
  belongs_to :campaign
end
