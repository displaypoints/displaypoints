class Activity
  include DataMapper::Resource

  property :id,         Serial
  property :type,       Discriminator
  property :created_at, DateTime, :nullable => false

  belongs_to :corporation
  belongs_to :user

  validates_present :corporation, :user

  before :valid?, :set_timestamps

  default_scope(:default).update(:order => [:created_at.desc])

  class NewCampaign < Activity
    belongs_to :campaign

    validates_present :campaign
  end

  class NewPage < Activity
    belongs_to :page

    validates_present :page
  end

  class ContractApproved < Activity
    belongs_to :contract

    validates_present :contract
  end
end