# dependencies are generated using a strict version, don't forget to edit the dependency versions when upgrading.
merb_gems_version = "1.0.9"
dm_gems_version   = "0.9.10"
do_gems_version   = "0.9.11"

# For more information about each component, please read http://wiki.merbivore.com/faqs/merb_components
dependency "merb-action-args",          merb_gems_version
dependency "merb-assets",               merb_gems_version
# dependency "merb-cache",                merb_gems_version
dependency "merb-helpers",              merb_gems_version
dependency "merb-mailer",               merb_gems_version
dependency "merb-slices",               merb_gems_version
dependency "merb-auth-core",            merb_gems_version
dependency "merb-auth-more",            merb_gems_version
dependency "merb-auth-slice-password",  merb_gems_version
dependency "merb-param-protection",     merb_gems_version
dependency "merb-exceptions",           merb_gems_version
dependency "merb-haml",                 merb_gems_version
 
dependency "dm-core",         dm_gems_version
dependency "dm-aggregates",   dm_gems_version
dependency "dm-migrations",   dm_gems_version
dependency "dm-timestamps",   dm_gems_version
dependency "dm-types",        dm_gems_version
dependency "dm-validations",  dm_gems_version
dependency "dm-is-tree",      dm_gems_version
dependency "dm-observer",     dm_gems_version
dependency "dm-serializer",   dm_gems_version

dependency "do_postgres", do_gems_version, :require_as => nil

dependency "dm-is-permalink", "~> 0.9"
dependency "facets",          "~> 2.4"
dependency "chronic",         "~> 0.2"
dependency "image_science",   "~> 1.1"
dependency "uuidtools",       "~> 1.0"
dependency "rack",            "~> 0.9"
dependency "facets",          "~> 2.4"
dependency "chronic",         "~> 0.2.3"

dependency "dm-sweatshop", dm_gems_version, :require_as => nil

dependency "merb_datamapper",     merb_gems_version
dependency "dm-couchdb-adapter",  dm_gems_version, :require_as => 'couchdb_adapter'

require "digest/md5"