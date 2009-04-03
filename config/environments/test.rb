Merb.logger.info("Loaded TEST Environment...")
Merb::Config.use { |c|
  c[:testing]           = true
  c[:exception_details] = true
  c[:log_auto_flush ]   = true
  # log less in testing environment
  c[:log_level]         = :error

  #c[:log_file]  = Merb.root / "log" / "test.log"
  # or redirect logger using IO handle
  c[:log_stream] = STDOUT
  c[:session_secret_key]  = '7084f695ebeca69cdb12ebda4ae80aeb70fb6bcc'
  c[:session_id_key] = '_dp-admanager_test_session_id'
}

Merb::BootLoader.before_app_loads do
  DataMapper.setup(:default, "sqlite3:config/sample_test.db")
  DataMapper.setup(:analytics, "couchdb://localhost:5984/dp-analytics")
  DataObjects::Postgres.logger = Merb.logger
end