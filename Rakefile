$PROJECT_ROOT=File.expand_path(File.dirname(__FILE__))

namespace :test do
  desc "run all unit test"
  task :unit do
    Dir['test/**/*_test.rb'].each { |testCase|
      tName = File.join($PROJECT_ROOT, testCase)
      puts "running test: #{tName}"
      load tName
    }
  end
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name              = "taas"
  gem.homepage          = "http://github.com/anandbagmar/taas"
  gem.license           = "Apache 2.0"
  gem.summary           = %q{TaaS}
  gem.description       = %q{"TaaS" allows you to validate the integration across a variety of products via Test Automation - the "correct" way. TaaS uses a web service interface to run your end-2-end integration tests between two independent but related system. See the blog for more details: http://goo.gl/nVShb}
  gem.authors           = ["Anand Bagmar, Akash Mishra"]
  gem.email             = ["abagmar@gmail.com, akash.mishra20@gmail.com"]
  gem.files.exclude "doc/**/*"
  gem.rubyforge_project = "taas"
end
Jeweler::RubygemsDotOrgTasks.new
