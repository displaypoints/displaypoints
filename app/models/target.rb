class Target
  include DataMapper::Resource

  property :id,     Serial

  belongs_to :campaign, :class_name => "Campaign"
  belongs_to :menu, :class_name => "Menu" #menu this target should open too when icon on parent menu is clicked

end
