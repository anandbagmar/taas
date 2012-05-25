# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "taas/version"

Gem::Specification.new do |s|
  s.name        = "taas"
  s.version     = Taas::VERSION
  s.authors     = ["Akash"]
  s.email       = ["akashm@thoughtworks.com"]
  s.homepage    = ""
  s.summary     = %q{Testing As A Services}
  s.description = %q{Gem provide a web services interface to run Test as a Services between two independent but related system}

  s.rubyforge_project = "taas"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"

  s.add_add_runtime_dependency "sinatra"
end
