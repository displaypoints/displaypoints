$KCODE = 'UTF8'
 
#
# ==== Structure of Merb initializer
#
# 1. Load paths.

Merb.push_path(:lib, Merb.root / "lib", nil) # uses **/*.rb as path glob.
Merb.push_path(:uploads, Merb.dir_for(:public) / :uploads, nil)
Merb.push_path(:pages, Merb.dir_for(:uploads), nil)
Merb.push_path(:thumbs, Merb.dir_for(:uploads), nil)

# 2. Dependencies configuration.

require 'config/dependencies.rb'

# 3. Libraries (ORM, testing tool, etc) you use.

use_orm :datamapper
use_test :rspec, 'dm-sweatshop'
use_template_engine :haml

# 4. Merb::Config entries.

Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'
end

require 'lib/extlib'

# 5. BootLoader callbacks.

Merb::BootLoader.before_app_loads do
  Dir[Merb.dir_for(:lib) / :preload / "**" / "*.rb"].each {|f| require f}
end

Merb::BootLoader.after_app_loads do
  Dir[Merb.dir_for(:lib) / :postload / "**" / "*.rb"].each {|f| require f}
end