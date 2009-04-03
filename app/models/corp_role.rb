class CorpRole
  include DataMapper::Resource
  
  property :id, Serial
  property :role, Enum[:dp, :ad, :venue], :nullable => false
  property :admin, Boolean, :default => false

  belongs_to :user
  belongs_to :corporation

  validates_present :user, :corporation

  def admin!
    update_attributes(:admin => true)
  end

  def user!
    update_attributes(:admin => false)
  end

  def admin?
    self.admin
  end

  def root?
    admin? && corporation.master? unless corporation.nil?
  end
  
  def users
    users = []
    if self.user.corporation.master
      users = User.all(:order => [:name])
    else
      users = User.all(:corporation_id => self.user.corporation.id)
    end
    return users
  end

  def campaigns
    if self.role == :dp
      return Campaign.all
    end
    return Campaign.all(:campaign.user.corporation_id = self.user.corporation.id)
  end

end
