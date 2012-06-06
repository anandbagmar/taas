# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "taas/version"

Gem::Specification.new do |s|
  s.name        = "taas"
  s.version     = TaaS::VERSION
  s.authors     = ["Anand Bagmar, Akash Mishra, Gaurav Pathak"]
  s.email       = ["abagmar@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TaaS: Test as a Service}
  s.description = %q{Gem provide a web services interface to run Test as a Services between two independent but related system}

  s.rubyforge_project = "taas"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"

  s.add_dependency "rake"
  s.add_dependency "sinatra"

  s.add_development_dependency "test-unit"
  s.add_development_dependency "mocha"
end
