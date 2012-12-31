# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "taas/version"

Gem::Specification.new do |s|
  s.name        = "taas"
  s.version     = TaaS::VERSION
  s.authors     = ["Anand Bagmar, Akash Mishra"]
  s.email       = ["abagmar@gmail.com, akash.mishra20@gmail.com"]
  s.homepage    = "https://github.com/anandbagmar/taas"
  s.summary     = %q{TaaS: Test as a Service}
  s.description = %q{“TaaS - Test as a Service” is a product that allows you to validate the integration across a variety of products via Test Automation - the “correct” way. TaaS uses a web service interface to run your end-2-end integration tests between two independent but related system. See the blog for more details: http://goo.gl/nVShb}

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
  s.add_dependency "json"

  s.add_development_dependency "test-unit"
  s.add_development_dependency "mocha"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "rack-test"
end
