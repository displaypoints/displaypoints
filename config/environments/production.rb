Merb.logger.info("Loaded PRODUCTION Environment...")
Merb::Config.use { |c|
  c[:exception_details] = false
  c[:reload_classes] = false
  c[:log_level] = :error
  c[:session_secret_key]  = '7084f695ebeca69cdb12ebda4ae80aeb70fb6bcc'
  c[:session_id_key] = 'dp_admanager_production'
  c[:session_store] = 'cookie'
  c[:bundle_assets] = true
}

Merb::Plugins.config[:merb_datamapper][:use_repository_block] = false

Merb::BootLoader.before_app_loads do
  DataMapper.setup(:default, "postgres://app:mak3ac9oc3@localhost/dp_admanager")
  DataMapper.setup(:analytics, "couchdb://localhost:5984/dp-analytics")
end