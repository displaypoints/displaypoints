Merb.logger.info("Loaded STAGING Environment...")
Merb::Config.use { |c|
  c[:exception_details] = false
  c[:reload_classes] = false
  c[:session_id_key] = 'dp_admanager_staging'
  c[:session_secret_key]  = '5c1f79f69832b6cfd7bdd5c0d6fb38086fdbfcfc'
  c[:session_store] = 'cookie'
  c[:bundle_assets] = true
}

Merb::BootLoader.before_app_loads do
  DataMapper.setup(:default, "postgres://app:aisibjiafi@localhost/staging")
  DataMapper.setup(:analytics, "couchdb://localhost:5984/dp-analytics")
end