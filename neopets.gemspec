# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "neopets/version"

Gem::Specification.new do |s|
  s.name        = "neopets"
  s.version     = Neopets::VERSION
  s.authors     = ["Matchu"]
  s.email       = ["matchu1993@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{access public information on Neopets.com}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  
  s.add_runtime_dependency "nokogiri", "~> 1.5.2"
  s.add_development_dependency "rspec", "~> 2.10.0"
  s.add_development_dependency "webmock", "~> 1.8.7"
end
