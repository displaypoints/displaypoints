# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dm-is-permalink}
  s.version = "0.9.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Smith"]
  s.autorequire = %q{dm-is-permalink}
  s.date = %q{2008-11-23}
  s.description = %q{DataMapper plugin for adding a permalink to a model}
  s.email = %q{wbsmith83@gmail.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/dm-is-permalink", "lib/dm-is-permalink/is", "lib/dm-is-permalink/is/permalink.rb", "lib/dm-is-permalink/is/version.rb", "lib/dm-is-permalink.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/sam/dm-more/tree/master/dm-is-permalink}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{DataMapper plugin for adding a permalink to a model}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
