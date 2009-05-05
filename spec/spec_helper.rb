require "rubygems"

if (local_gem_dir = File.join(File.dirname(__FILE__), '..', 'gems')) && $BUNDLE.nil?
  $BUNDLE = true; Gem.clear_paths; Gem.path.unshift(local_gem_dir)
end

require 'merb-core'
require 'spec' # Satisfies Autotest and anyone else not using the Rake tasks

Merb.start_environment(:testing => true, :adapter => 'runner', :environment => ENV['MERB_ENV'] || 'test')

Spec::Runner.configure do |config|
  config.include(Merb::Test::ViewHelper)
  config.include(Merb::Test::RouteHelper)
  config.include(Merb::Test::ControllerHelper)

  config.before(:all) do
    DataMapper.auto_migrate! if Merb.orm == :datamapper
  end

  config.before do
    @time_now = Time.now
    Time.stub!(:now).and_return(@time_now)
  end

  config.before do
    repository do |r|
      transaction = DataMapper::Transaction.new(r)
      transaction.begin
      r.adapter.push_transaction(transaction)
    end
  end
  
  config.after do
    repository do |r|
      adapter = r.adapter
      while adapter.current_transaction
        adapter.current_transaction.rollback
        adapter.pop_transaction
      end
    end
  end
end

Dir[Merb.root / 'spec' / 'fixtures'/ '**' / '*_fix.rb'].each {|f| require f}
Dir[Merb.root / 'spec' / 'shared' / '*.rb' ].each { |f| require f }