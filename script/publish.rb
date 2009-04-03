#require 'rubygems'
#Gem.clear_paths
#Gem.path.unshift("gems")
#require 'merb-core'
require 'pp'
require 'json/pure'


#Dir.chdir File.join(File.dirname(__FILE__), '..')

#Merb.start_environment(:adapter => 'runner', :environment => 'development')

dbase = DeployBase.first
publisher = Publisher.new(dbase)
publisher.build
publisher.write_out
