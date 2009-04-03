# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{image_science}
  s.version = "1.1.3"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Davis"]
  s.cert_chain = nil
  s.date = %q{2007-05-29}
  s.description = %q{ImageScience is a clean and happy Ruby library that generates thumbnails -- and kicks the living crap out of RMagick. Oh, and it doesn't leak memory like a sieve. :) For more information including build steps, see http://seattlerb.rubyforge.org/}
  s.email = %q{ryand-ruby@zenspider.com}
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "bench.rb", "lib/image_science.rb", "quick_thumb", "test/pix.png", "test/test_image_science.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://seattlerb.rubyforge.org/ImageScience.html}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = %q{seattlerb}
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{ImageScience is a clean and happy Ruby library that generates thumbnails -- and kicks the living crap out of RMagick.}
  s.test_files = ["test/test_image_science.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<RubyInline>, ["> 0.0.0"])
      s.add_runtime_dependency(%q<hoe>, [">= 1.2.1"])
    else
      s.add_dependency(%q<RubyInline>, ["> 0.0.0"])
      s.add_dependency(%q<hoe>, [">= 1.2.1"])
    end
  else
    s.add_dependency(%q<RubyInline>, ["> 0.0.0"])
    s.add_dependency(%q<hoe>, [">= 1.2.1"])
  end
end
