Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
  match('/').to(:controller => "home", :action => "index").name(:home)
  match("/forbidden").to(:controller => "exceptions", :action => "forbidden").name(:forbidden)
  
  to(:controller => "users") do
    match("/users", :method => :post).to(:action => "create").name(:users)
    match("/users").to(:action => "index").name(:users)
    match("/user/new").to(:action => "new").name(:new_user)
    match("/user/:id/hijack").to(:action => "hijack").name(:hijack_user)
    match("/user/:id/edit", :method => :put).to(:action => "update")
    match("/user/:id/edit").to(:action => "edit").name(:edit_user)
    match("/user/:id", :method => :delete).to(:action => "destroy").name(:user)
    match("/user/:id").to(:action => "show").name(:user)
  end

  identify(Asset => :slug) do    
    to(:controller => 'assets') do
      match("/assets", :method => :post).to(:action => "create").name(:assets)
      match("/assets/new").to(:action => "new").name(:new_asset)
      match("/display/checkin").to(:action => 'check_in').name(:checkin)
      match("/assets").to(:action => "index").name(:assets)
      match("/display/update/available").to(:action => 'start_update').name(:start_update)
      match("/display/update/status").to(:action => 'finish_update').name(:finish_update)
      match("/asset/:slug", :method => :delete).to(:action => "destroy").name(:asset)
      match("/asset/:slug", :method => :put).to(:action => "update").name(:asset)
      match("/asset/:slug").to(:action => "show").name(:asset)
      match("/asset/:slug/edit").to(:action => "edit").name(:edit_asset)
    end
  end
  
  to(:controller => "venues") do
    match("/venues", :method => :post).to(:action => "create")
    match("/venues").to(:action => "index").name(:venues)
    match("/venue/new").to(:action => "new").name(:new_venue)
    match("/venue/:id/edit", :method => :put).to(:action => "update")
    match("/venue/:id/edit").to(:action => "edit").name(:edit_venue)
    match("/venue/:id", :method => :delete).to(:action => "destroy")
    match("/venue/:id").to(:action => "show").name(:venue)
    match("/manifest").to(:action => "manifest").name(:manifest)
#    venue.match("/corporation/:corp/venue/:slug/edit", :method => :put).to(:action => "update")
#    venue.match("/corporation/:corp/venue/:slug/edit").to(:action => "edit").name(:edit_venue)
#    venue.match("/corporation/:corp/venue/:slug", :method => :delete).to(:action => "destroy")
#    venue.match("/corporation/:corp/venue/:slug").to(:action => "show").name(:venue)
  end

  identify(Page => :id) do
    to(:controller => 'pages') do
      match('/page/new', :method => :post).to(:action => 'create_root').name(:pages)
      match('/page/new').to(:action => 'new_root').name(:new_root_page)
      match('/page/:id/new', :method => :post).to(:action => 'create_child').name(:child_pages)
      match('/page/:id/new').to(:action => 'new_child').name(:new_child_page)
      match('/page/clone', :method => :post).to(:action => 'clone_page').name(:clone_page)
      match('/page/:id').to(:action => 'show').name(:page)
      match('/pages').to(:action => 'index').name(:pages)
    end
  end
  
  to(:controller => "inquiries") do
    match('/page/:page_id/inquiries', :method => :post).to(:action => "create").name(:inquiries)
    match('/page/:page_id/inquiries/:id', :method => :post).to(:action => "update").name(:inquiry)
    match('/page/:page_id/inquiries/:id', :method => :delete).to(:action => "destroy").name(:inquiry)
  end
  
  match('/page/:page_id/survey', :method => :put).to(:controller => "surveys", :action => "update").name(:update_survey)
  
  identify(Corporation => :slug) do
    to(:controller => "corporations") do |corporation|
      match("/corporations", :method => :post).to(:action => "create")
      match("/corporations").to(:action => "index").name(:corporations)
      match("/corporation/new").to(:action => "new").name(:new_corporation)
      match("/corporation/:slug/edit").to(:action => "edit").name(:edit_corporation)
      match("/corporation/:slug", :method => :put).to(:action => "update")
      match("/corporation/:slug", :method => :delete).to(:action => "destroy")
      match("/corporation/:slug").to(:action => "show").name(:corporation)
    end
  end

  identify(PublishGroup => :slug) do
    to(:controller => 'publish_groups') do
      match('/publish_group/new', :method => :post).to(:action => 'create')
      match('/publish_group/new').to(:action => 'new').name(:new_publish_group)
      match('/publish_group/:id').to(:action => 'show').name(:publish_group)
      match('/publish_groups(.:format)').to(:action => 'index').name(:publish_groups)
    end
  end

  identify(ContentItem => :id) do
    to(:controller => 'content_items') do
      match('/content_items', :method => :post).to(:action => 'create')
      match('/content_item/new').to(:action => 'new').name(:new_content_item)
      match('/content_item/:id').to(:action => :show).name(:content_item)
      match('/content_items').to(:action => 'index').name(:content_items)
    end
  end
  
  identify(Contract => :id) do
    to(:controller => 'contracts') do
      match("/contracts", :method => :post).to(:action => "create").name(:contracts)
      match("/contracts").to(:action => "index").name(:contracts)
      match("/contract/new").to(:action => "new").name(:new_contract)
      match("/contract/:id/edit").to(:action => "edit").name(:edit_contract)
      match("/contract/:id/approve").to(:action => "approve").name(:approve_contract)
      match("/contract/:id/unapprove").to(:action => "unapprove").name(:unapprove_contract)
      match("/contract/:id", :method => :put).to(:action => "update")
      match("/contract/:id", :method => :delete).to(:action => "destroy")
      match("/contract/:id").to(:action => "show").name(:contract)
    end
  end

  to(:controller => "links") do
    match("/page/:parent_id/links", :method => :post).to(:action => "create").name(:links)
    match("/page/:parent_id/link/new").to(:action => "new").name(:new_link)
    match("/page/:parent_id/link/:id/edit").to(:action => "edit").name(:edit_link)
    match("/page/:parent_id/link/:id/remove").to(:action => "remove").name(:remove_link)
    match("/page/:parent_id/link/:id", :method => :put).to(:action => "update").name(:link)
    match("/page/:parent_id/link/:id", :method => :delete).to(:action => "destroy").name(:link)
  end
  
  identify(Campaign => :id) do
    to(:controller => "campaigns") do
      match("/campaigns", :method => :post).to(:action => "create").name(:campaigns)
      match("/campaigns").to(:action => "index").name(:campaigns)
      match("/campaign/new").to(:action => "new").name(:new_campaign)
      match("/campaign/:id/edit").to(:action => "edit").name(:edit_campaign)
      match("/campaign/:id", :method => :put).to(:action => "update").name(:campaign)
      match("/campaign/:id").to(:action => "show").name(:campaign)
      match("/campaign/:id/content/new").to(:action => "new_content").name(:campaign_new_content)
      match("/campaign/:id/content", :method => :post).to(:action => "add_content").name(:campaign_add_content)
    end
    to(:controller => "contracts") do
      match("/campaign/:campaign_id/contract/new").to(:action => "new").name(:campaign_new_contract)
      match("/campaign/:campaign_id/contract", :method => :post).to(:action => "create").name(:campaign_add_contract)
    end
  end

  to(:controller => "analytics") do
    match("/analytics", :method => :post).to(:action => "create")
    match("/analytics").to(:action => "index").name(:analytics)
    match("/campaign/:campaign_id/analytics(.:format)").to(:action => "campaign_show").name(:campaign_analytics)
    match("/content_item/:content_item_id/analytics(.:format)").to(:action => "content_item_show").name(:campaign_analytics)
  end

  to(:controller => "admin") do
    match('/admin').to(:controller => "admin", :action => "dash").name(:admin_dash)
    match("/admin/gencontent").to(:action => "gen_content").name(:gencontent)
  end


  add_slice(:MerbAuthSlicePassword, :path_prefix => '', :name_prefix => nil, :default_routes => false)
  match("/login", :method => :get).to(:controller => "exceptions", :action => "unauthenticated").name(:login)

end
