Campaign.fixture {{
  :name             => (2..5).of {/\w+/.gen.capitalize} * ' ',
  :publish_groups   => (1..3).of {PublishGroup.gen}.uniq,
  :content_items    => (1..3).of {ContentItem.gen(:advertisement)}.uniq,  
}}

Campaign.fixture(:venue){{
  :name             => (2..5).of {/\w+/.gen.capitalize} * ' ',
  :publish_groups   => (1..3).of {PublishGroup.gen}.uniq,
  :content_items    => (1..3).of {ContentItem.gen(:advertisement)}.uniq,
  :exec => user = User.gen(:venue_admin),
  :corporation => user.corporation
}}

Campaign.fixture(:empty_item) {{
  :name             => (2..5).of {/\w+/.gen.capitalize} * ' ',
  :publish_groups   => (1..3).of {PublishGroup.gen}.uniq,
  :content_items    => [],
  :corporation      => Corporation.gen(:ad),
  :exec             => User.make(:ad_admin)
}}

given "an empty item campaign => @empty_item_campaign" do
  @empty_item_campaign = Campaign.gen(:empty_item)
end

given "an add campaign => @ad_campaign" do
  @corp = Corporation.gen(:ad); Page.gen(:root); 3.times {Tag.gen}
  @user = User.gen(:ad_user)
  @user.corp_role = CorpRole.gen(:user => @user, :corporation => @corp)
  @user.activate!
  @ad_campaign = Campaign.gen(:empty_item, :exec => @user)
end

given "a content campaign => @content_campaign" do
  @corp = Corporation.gen; Page.gen(:root); 3.times {Tag.gen}
  @user = User.gen(:ad_user)
  @user.corp_role = CorpRole.gen(:user => @user, :corporation => @corp)
  @user.activate!
  @content_campaign = Campaign.gen(:empty_item, :exec => @user)
end

given "a campaign => @campaign" do
  @campaign = Campaign.gen(:empty_item)
end

given "an unsaved campaign => @campaign" do
  @campaign = Campaign.make(:empty_item)
end

given "an empty campaign => @campaign" do
  @campaign = Campaign.gen(:empty_item)
end

given "a campaign with files => @campaign" do
  5.times {Page.gen(:root)}; 3.times {Tag.gen}
  @campaign = Campaign.gen
end

given "an initiated campaign => @campaign" do
  @campaign = Campaign.gen(:empty_item)
  @campaign.exec.corp_role = CorpRole.gen(:role => :ad, :admin => true, :corporation => @campaign.corporation, :user => @campaign.exec)
  @campaign.exec.reload
end