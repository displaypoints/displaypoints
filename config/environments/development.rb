Merb.logger.info("Loaded DEVELOPMENT Environment...")
Merb::Config.use { |c|
  c[:exception_details] = true
  c[:reload_templates] = true
  c[:reload_classes] = true
  c[:reload_time] = 0.5
  c[:ignore_tampered_cookies] = true
  c[:log_auto_flush ] = true
  c[:log_level] = :debug

  c[:log_stream] = STDOUT
  c[:log_file]   = nil
  c[:session_secret_key]  = '7084f695ebeca69cdb12ebda4ae80aeb70fb6bcc'
  c[:session_id_key] = '_dp-admanager_dev_session_id'
}

Merb::BootLoader.before_app_loads do
  DataMapper.setup(:default, "postgres://postgres:postgres123@localhost/dp_admanager_dev")
    DataMapper.setup(:analytics, "couchdb://localhost:5984/dp-analytics")
    DataObjects::Postgres.logger = Merb.logger
#  DataMapper.setup(:default, "sqlite3:" + Merb.root / 'dp_ad_dev.db')
#  DataObjects::Sqlite3.logger = Merb.logger
#  DataMapper.setup(:analytics, "couchdb://localhost:5984/dp-analytics")
end

Merb::BootLoader.before_app_loads do
end
